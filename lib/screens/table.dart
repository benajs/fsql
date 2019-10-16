import 'package:flutter/material.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/store.dart';

class ResultTable extends StatefulWidget {
  ResultTable({Key key}) : super(key: key);
  final String title = "Data Table Connections";
  _ResultTableState createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
  LocalStorageService storageService = new LocalStorageService();
  List<Connection> myConnections = new List();
  List<Connection> selectedConnections = new List();

  bool sort = true;
  @override
  void initState() {
    myConnections = storageService.getAllConnection();
    selectedConnections = [];
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        myConnections.sort((a, b) => a.name.compareTo(b.name));
      } else {
        myConnections.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  onSelectedRow(bool selected, Connection con) async {
    setState(() {
      if (selected) {
        selectedConnections.add(con);
      } else {
        selectedConnections.remove(con);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedConnections.isNotEmpty) {
        List<Connection> temp = [];
        temp.addAll(selectedConnections);
        for (Connection con in temp) {
          myConnections.remove(con);
          selectedConnections.remove(con);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    print(myConnections.length);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("NAME"),
              numeric: false,
              tooltip: "This is First Name",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("NAME"),
            numeric: false,
            tooltip: "This is Last Name",
          ),
        ],
        rows: myConnections
            .map(
              (user) => DataRow(
                  selected: selectedConnections.contains(user),
                  onSelectChanged: (b) {
                    print("Onselect");
                    onSelectedRow(b, user);
                  },
                  cells: [
                    DataCell(
                      Text(user.name),
                      onTap: () {
                        print('Selected ${user.name}');
                      },
                    ),
                    DataCell(
                      Text(user.name),
                    ),
                  ]),
            )
            .toList(),
      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: OutlineButton(
                    child: Text('SELECTED ${selectedConnections.length}'),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: OutlineButton(
                    child: Text('DELETE SELECTED'),
                    onPressed: selectedConnections.isEmpty
                        ? null
                        : () {
                            deleteSelected();
                          },
                  ),
                ),
              ],
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
}
