import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsql/main.dart';
import 'package:fsql/screens/addDBConnection.dart';
import 'package:fsql/screens/table.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: "Francium SQL"));
      case 'addConnection':
        return MaterialPageRoute(builder: (_) => AddConnection());
      case 'resultTable':
        return MaterialPageRoute(builder: (_) => ResultTable());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
