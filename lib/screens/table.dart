import 'package:flutter/material.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/psql.dart';
import 'package:fsql/utils/store.dart';

class ConnectionTable extends StatefulWidget {
  ConnectionTable({Key key}) : super(key: key);
  final String title = "Data Table Connections";
  _ConnectionTableState createState() => _ConnectionTableState();
}

class _ConnectionTableState extends State<ConnectionTable> {
  LocalStorageService storageService = new LocalStorageService();
  List<Connection> myConnections = new List();
  List<Connection> selectedConnections = new List();
  List<List<dynamic>> results;

  bool sort = true;
  @override
  void initState() {
    getInstance();
    myConnections = storageService.getAllConnectionDetails();
    super.initState();
  }

  getInstance() {
    var instance = LocalStorageService.getInstance();

    return instance;
  }

  onSortColum(int columnIndex, bool ascending) {
    if (ascending) {
      myConnections.sort((a, b) => a.name.compareTo(b.name));
    } else {
      myConnections.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  connectDB(Connection con) async {
    results = await executeQuery(con);
    setState(() {
      Navigator.pushNamed(context, 'resultTable', arguments: results);
    });
  }

  dataBody() {
    int sortColumn = 0;
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
    DbConnect db = new DbConnect();
    var results = await db.executeQuery(conn, "");
    return results;
  }
}
