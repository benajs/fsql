import 'package:flutter/foundation.dart';
import 'package:fsql/data/connections.dart';
import 'package:fsql/utils/store.dart';

class ConnectionList extends ChangeNotifier {
  List<Connection> myConnections = new List();
  LocalStorageService storageService = new LocalStorageService();

  ConnectionList() {
    getConnections();
  }

  addConnection(newConnectionData) {
    storageService.setConnection(newConnectionData);
    myConnections.add(newConnectionData);
    notifyListeners();
  }

  getConnections() {
    myConnections = storageService.getAllConnectionDetails();
    notifyListeners();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (ascending) {
      myConnections.sort((a, b) => a.name.compareTo(b.name));
    } else {
      myConnections.sort((a, b) => b.name.compareTo(a.name));
    }
    notifyListeners();
  }
}
