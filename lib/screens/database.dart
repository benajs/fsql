import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/data/queryExecutor.dart';
import 'package:fsql/screens/results.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Database extends StatefulWidget {
  final Connection con;

  Database(this.con, {Key key}) : super(key: key);

  _DatabaseState createState() => _DatabaseState(con);
}

class _DatabaseState extends State<Database> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<dynamic> schema;
  QueryExecutor queryExecutor;
  int _currentIndex = 0;
  Connection con;
  String queryInput = "";
  TextEditingController queryInputController = TextEditingController();

  String title;

  _DatabaseState(this.con);

  @override
  Widget build(BuildContext context) {
    queryExecutor = Provider.of<QueryExecutor>(context);
    queryExecutor.con = this.con;

    final List<Widget> _tabs = [
      displaySchema(),
      buildQuery(),
      buildResults(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text('Tables'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.query_builder),
              title: Text('Query'),
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in), title: Text('Results'))
          ],
        ),
      ),
    );
  }

  displaySchema() {
  //  getSchema();
    title = con.name + " - Schema";
    return Scaffold(
        body: schema != null
            ? SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                header: WaterDropHeader(),
                onRefresh: _onRefresh,
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: schema
                      .map((data) => ListTile(
                            leading: Icon(Icons.border_horizontal),
                            title: Text(data[0]),
                            subtitle: Text("Db Table"),
                          ))
                      .toList(),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  getSchemas() async {
    schema = await queryExecutor.getSchema();
  }

  void _onRefresh() async {
 //   getSchema();
    _refreshController.refreshCompleted();
  }

  buildQuery() {
    title = con.name + " - Query";

    if (queryExecutor.query != "") {
      queryInputController.text = queryExecutor.query;
    }

    return Scaffold(
      body: Container(
        child: Column(children: [
          RaisedButton(
            child: Text("Upload Query"),
            onPressed: () => readFile(),
          ),
          TextField(
            controller: queryInputController,
            style: TextStyle(fontSize: 20.0),
            decoration:
                InputDecoration.collapsed(hintText: 'Enter the query here'),
            autofocus: true,
            maxLines: null,
            onChanged: (text) {
              queryInput = text;
            },
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          queryExecutor.query = queryInput;
          queryExecutor.executeQuery();
          onTabTapped(2);
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.green,
      ),
    );
  }

  buildResults() {
    title = con.name + " - Results";

    return queryExecutor.results == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ResultTable(queryExecutor.results);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void readFile() async {
    queryInputController.text = await getpicker();
  }

  getpicker() async {
    //  String filePath = await FilePicker.getFilePath(type: FileType.ANY);
    File file = await FilePicker.getFile(type: FileType.ANY);
    //print(filePath);
    String content = await file.readAsString();
    print(content);

    return content;
  }
}
