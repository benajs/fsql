import 'dart:convert';

import 'package:fsql/data/connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static bool isLoaded = false;
  LocalStorageService();

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
      isLoaded = true;
      print(_preferences);
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

  List<Connection> getAllConnectionDetails() {
    List<Connection> allConnections = new List<Connection>();

    if (isLoaded) {
      Set<String> keys = _preferences.getKeys();
      for (var key in keys) {
        Connection con =
            Connection.fromJson(json.decode(_preferences.get(key)));
        allConnections.add(con);
      }
    }
    return allConnections;
  }

  List<String> getAllConnections() {
    List<String> keys = _preferences.getKeys() as List<String>;
    return keys;
  }

  resetApp() {
    _preferences.clear();
  }
}
