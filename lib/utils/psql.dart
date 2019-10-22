import 'package:fsql/data/connections.dart';
import 'package:postgres/postgres.dart';

class DbConnect {
  var connection;
  var results;

  Future<void> connectDatabase(Connection db) async {
    connection = new PostgreSQLConnection(db.host, db.port, db.database,
        username: db.username, password: db.password);
    await connection.open();
  }

  executeQuery(Connection db, String query) async {
    query = "select name as \"topic\", ref_url from topics";
    await connectDatabase(db);
    results = await connection.mappedResultsQuery(query);
    List<List<dynamic>> resultList, processedResults = new List();

    processedResults.add(getColumnsFromMap(results));

    //get values as list
    resultList = await connection.query(query);

    processedResults.addAll(resultList);

    return processedResults;
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
}
