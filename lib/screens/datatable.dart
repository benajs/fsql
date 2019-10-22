import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultTable extends StatefulWidget {
  ResultTable(this.results, {Key key}) : super(key: key);

  final results;
  final String title = "Results Table";
  _ResultTableState createState() => _ResultTableState(results);
}

class _ResultTableState extends State<ResultTable> {
  List<List<dynamic>> results;
  var records;
  List<DataColumn> headers;
  bool sort = true;

  _ResultTableState(results) {
    this.results = results;

    this.headers = getColumnHeaders(this.results.first);
    this.results.removeAt(0);
    this.records = getRows(this.results); //TODO
  }

  @override
  void initState() {
    super.initState();
  }

  getColumnHeaders(List columns) {
    headers = new List<DataColumn>();
    for (var col in columns) {
      DataColumn dc = DataColumn(
          label: Text(
            col.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          numeric: false,
          tooltip: col.toString());
      headers.add(dc);
    }
    return headers;
  }

  List<DataRow> getRows(List recordsList) {
    var records = recordsList;
    List<DataRow> rows = new List<DataRow>();
    for (var user in records) {
      rows.add(new DataRow(cells: buildRow(user)));
    }
    return rows;
  }

  buildRow(record) {
    List<DataCell> row = new List<DataCell>();
    for (var value in record) {
      row.add(DataCell(
        Text(value.toString()),
      ));
    }
    return row;
  }

  dataBody() {
    return CupertinoScrollbar(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CupertinoScrollbar(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                        columns: headers,
                        //getColumnHeaders(["Name", "Host"]),
                        rows: records)
                    //getRows(myConnections)),
                    ))));
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
        ));
  }
}
