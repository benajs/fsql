import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fsql/data/connections.dart';
import 'package:postgres/postgres.dart';

class QueryExecutor extends ChangeNotifier {
  Connection con;
  String query;
  List<String> columns;
  String sort;
  String where;
  List<List<dynamic>> results, schema;
  var connection;

  QueryExecutor(
      {this.con,
      this.query,
      this.columns,
      this.sort,
      this.where,
      this.results});

  QueryExecutor.fromJson(Map<String, dynamic> json) {
    con = json['con'];
    query = json['query'];
    columns = json['columns'].cast<String>();
    sort = json['sort'];
    where = json['where'];
    results = json['results'].cast<List<dynamic>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['columns'] = this.columns;
    data['sort'] = this.sort;
    data['where'] = this.where;
    data['results'] = this.results;
    data['con'] = this.con;
    return data;
  }

  connectDatabase() async {
    if (connection == null) {
      connection = new PostgreSQLConnection(con.host, con.port, con.database,
          username: con.username, password: con.password);
      await connection.open();
    } else if (connection.isClosed) await connection.open();

    return connection;
  }

  executeQuery() async {
    await connectDatabase();

    var resultMap = await connection.mappedResultsQuery(query);
    List<List<dynamic>> resultList, processedResults = new List();

    processedResults.add(getColumnsFromMap(resultMap));

    resultList = await connection.query(query);

    processedResults.addAll(resultList);

    results = processedResults;

    notifyListeners();

    return processedResults;
  }

  getSchema() async {
    await connectDatabase();

    var results1 = await connection.query(
        "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'");
    return results1;
  }

  getValuesFromMap(results) {
    for (var records in results) {
      Map tables = Map.from(records);
      List<dynamic> cells = new List();
      tables.forEach((k, v) {
        Map values = Map.from(v);
        cells.addAll(values.values.toList());
      });
      return cells;
    }
  }

  getColumnsFromMap(results) {
    // Gets the column names as list
    Map tables = Map.from(results.first);
    List<dynamic> cells = new List();
    tables.forEach((k, v) {
      Map values = Map.from(v);
      var cols = values.keys.toList().map((col) => "$k.$col").toList();
      cells.addAll(cols);
    });
    return cells;
  }

  updateQuery(String changedQuery) {
    this.query = changedQuery;
    executeQuery();
    notifyListeners();
  }

  saveQuery(String name) {
//    con.queries.add(Queries(name,this.query));
  }

  @override
  void dispose() {
    connection.close();
    super.dispose();
  }
}
