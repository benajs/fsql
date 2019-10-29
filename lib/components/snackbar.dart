import 'package:flutter/material.dart';

class SnackNotification extends StatefulWidget {
  final String content, type;
  SnackNotification(this.content, this.type, {Key key}) : super(key: key);

  _SnackNotificationState createState() =>
      _SnackNotificationState(this.content, this.type);
}

class _SnackNotificationState extends State<SnackNotification> {
  var bgColor;

  String content;

  var type;

  _SnackNotificationState(content, type);

  @override
  Widget build(BuildContext context) {
    switch (this.type) {
      case 'error':
        bgColor = Theme.of(context).errorColor;
        break;

      case 'primary':
        bgColor = Theme.of(context).primaryColor;
        break;

      case 'success':
        bgColor = Colors.greenAccent;
        break;
      default:
        bgColor = Colors.blueGrey;
        break;
    }
    return SnackBar(content: Text(this.content), backgroundColor: bgColor);
  }
}
