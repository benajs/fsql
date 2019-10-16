import 'package:fsql/data/connections.dart';
import 'package:postgres/postgres.dart';

class DbConnect {
  var connection;
  List<Map<String, Map<String, dynamic>>> results;

  Future<void> connectDatabase(Connection db) async {
    connection = new PostgreSQLConnection(db.host, db.port, db.database,
        username: db.username, password: db.password);
    await connection.open();
  }

  Future<void> executeQuery(Connection db) async {
    await connectDatabase(db);
    results = await connection.mappedResultsQuery("SELECT * FROM profiles");
    print(results);

    List<List<dynamic>> results2 =
        await connection.query("SELECT * FROM profiles");
    print(results2);
  }
}
