import 'dart:convert';

import 'package:fsql/data/connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static Future<LocalStorageService> getInstance() async {
    print("Location service instance called");
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  Connection getConnection(connectionKey) {
    var connectionJson = _getFromDisk(connectionKey);
    if (connectionJson == null) {
      return null;
    }
    return Connection.fromJson(json.decode(connectionJson));
  }

  setConnection(Connection connectionToSave) {
    print(connectionToSave);
    _preferences.setString(
        connectionToSave.name, json.encode(connectionToSave.toJson()));
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void saveStringToDisk(String key, String content) {
    _preferences.setString(key, content);
  }

  List<Connection> getAllConnection() {
    Set<String> keys = _preferences.getKeys();
    List<Connection> allConnections = new List<Connection>();
    for (var key in keys) {
      Connection con = Connection.fromJson(json.decode(_preferences.get(key)));
      allConnections.add(con);
    }
    return allConnections;
  }
}
