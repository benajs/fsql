class QueryProvider {
  String query;
  String table;
  List<String> columns;
  String sort;
  String where;
  List<List<dynamic>> results;

  QueryProvider(
      {this.query,
      this.table,
      this.columns,
      this.sort,
      this.where,
      this.results});

  QueryProvider.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    table = json['table'];
    columns = json['columns'].cast<String>();
    sort = json['sort'];
    where = json['where'];
    results = json['results'].cast<List<dynamic>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['table'] = this.table;
    data['columns'] = this.columns;
    data['sort'] = this.sort;
    data['where'] = this.where;
    data['results'] = this.results;
    return data;
  }
}
