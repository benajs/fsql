import 'package:flutter/material.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/store.dart';

class AddNewConnection extends StatefulWidget {
  const AddNewConnection();

  @override
  AddNewConnectionState createState() => new AddNewConnectionState();
}

class AddNewConnectionState extends State {
  Connection newConnectionData = new Connection();
  LocalStorageService storageService = new LocalStorageService();

  bool hidePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new ListView(
            children: <Widget>[
              new ListTile(title: const Text('Add New Connection')),
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
                  onChanged: (String database) {
                    newConnectionData.database = database.trim();
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
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.power_input),
                title: new TextField(
                  decoration: const InputDecoration(
                    hintText: "5432",
                  ),
                  onChanged: (String port) {
                    newConnectionData.port = port.trim();
                  },
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(flex: 1, child: new Container()),
                    new Expanded(
                        flex: 2,
                        child: new RaisedButton(
                          onPressed: () {
                            //   _testNewConnection(newConnectionData);
                          },
                          child: new Text('Test'),
                        )),
                    new Expanded(
                        flex: 2,
                        child: new RaisedButton(
                          onPressed: () {
                            storageService.setConnection(newConnectionData);
                          },
                          child: new Text('Save'),
                        )),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: DefaultTextStyle.of(context).style.textBaseline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
