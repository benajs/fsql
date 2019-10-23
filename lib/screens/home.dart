import 'package:flutter/material.dart';
import 'package:fsql/data/connectionList.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/psql.dart';
import 'package:provider/provider.dart';

class ConnectionTable extends StatefulWidget {
  ConnectionTable({Key key}) : super(key: key);
  final String title = "Data Table Connections";
  _ConnectionTableState createState() => _ConnectionTableState();
}

class _ConnectionTableState extends State<ConnectionTable> {
  List<List<dynamic>> results;

  bool sort = true;
  @override
  void initState() {
    super.initState();
  }

  connectDB(Connection con) async {
    results = await executeQuery(con);
    setState(() {
      Navigator.pushNamed(context, 'resultTable', arguments: results);
    });
  }

  dataBody() {
    var conProvider = Provider.of<ConnectionList>(context);
    var myConnections = conProvider.myConnections;
    if (myConnections.isNotEmpty)
      return ListView(
          scrollDirection: Axis.vertical,
          children: myConnections
              .map((con) => ListTile(
                    title: Text(con.name),
                    onTap: () {
                      connectDB(con);
                    },
                  ))
              .toList());
    else
      return Container(
        child: Text("No Connections"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Expanded(
              child: dataBody(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              'addConnection',
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  executeQuery(conn) async {
    try {
      DbConnect db = new DbConnect();
      var results = await db.executeQuery(conn, "");
      return results;
    } catch (e) {}
  }
}
