import 'package:flutter/material.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/store.dart';

class AddConnection extends StatefulWidget {
  AddConnection({AddConnection key}) : super();

  _AddConnectionState createState() => _AddConnectionState();
}

class _AddConnectionState extends State<AddConnection> {
  Connection newConnectionData = new Connection();
  LocalStorageService storageService = new LocalStorageService();

  bool hidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageService.getInstance();
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New connection"),
        ),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "my connection",
                      ),
                      onChanged: (String name) {
                        newConnectionData.name = name.trim();
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_ethernet),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "localhost",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String host) {
                        newConnectionData.host = host.trim();
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.folder),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "default database",
                      ),
                      onChanged: (String defaultDB) {
                        newConnectionData.database = defaultDB.trim();
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.person),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "username",
                      ),
                      onChanged: (String username) {
                        newConnectionData.username = username.trim();
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "password",
                      ),
                      onChanged: (String password) {
                        newConnectionData.password = password.trim();
                      },
                      obscureText: hidePassword,
                    ),
                    trailing: IconButton(
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.power_input),
                    title: new TextField(
                      decoration: const InputDecoration(
                        hintText: "5432",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String port) {
                        newConnectionData.port = num.parse(port);
                      },
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.all(10.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 2,
                              child: new RaisedButton(
                                onPressed: () {
                                  storageService
                                      .setConnection(newConnectionData);
                                  Navigator.pushNamed(
                                    context,
                                    'resultTable',
                                  );
                                },
                                child: new Text('Save'),
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ],
        )));
  }
}
