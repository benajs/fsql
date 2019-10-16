class Connection {
  String name;
  String host;
  int port;
  String username;
  String password;
  String database;
  List<Queries> queries;

  Connection(
      {this.name,
      this.host,
      this.port,
      this.username,
      this.password,
      this.database,
      this.queries});

  Connection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    host = json['host'];
    port = num.parse(json['port'].toString());
    username = json['username'];
    password = json['password'];
    database = json['database'];
    if (json['queries'] != null) {
      queries = new List<Queries>();
      json['queries'].forEach((v) {
        queries.add(new Queries.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['host'] = this.host;
    data['port'] = this.port.toInt();
    data['username'] = this.username;
    data['password'] = this.password;
    data['database'] = this.database;
    if (this.queries != null) {
      data['queries'] = this.queries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Queries {
  String name;
  String query;

  Queries({this.name, this.query});

  Queries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['query'] = this.query;
    return data;
  }
}
