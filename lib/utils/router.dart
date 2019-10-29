import 'package:flutter/material.dart';
import 'package:fsql/data/connectionList.dart';
import 'package:fsql/data/queryExecutor.dart';
import 'package:fsql/main.dart';
import 'package:fsql/screens/addConnection.dart';
import 'package:fsql/screens/database.dart';
import 'package:fsql/screens/home.dart';
import 'package:fsql/screens/results.dart';
import 'package:provider/provider.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: "Francium SQL"));
      case 'addConnection':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<ConnectionList>(
                  builder: (_) => ConnectionList(),
                  child: AddConnection(),
                ));

      case 'connectionTable':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<ConnectionList>(
                  builder: (context) => ConnectionList(),
                  child: ConnectionTable(),
                ));
      case 'connectionScreen':
        var con = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<QueryExecutor>(
                builder: (context) => QueryExecutor(), child: Database(con)));
      case 'resultTable':
        var results = settings.arguments;
        return MaterialPageRoute(builder: (_) => ResultTable(results));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
