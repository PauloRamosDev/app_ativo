import 'package:appativo/sheet.dart';

class ProviderDatabase {
  List<dynamic> database;
  bool loading;
  var cabecalho;

  ProviderDatabase() {
    _getData();
  }

  _getData() {
    loading = true;

    Sheet(null).getDataBase().then((value) {
      if (value.length > 0) cabecalho = value[0];
      database = value;
      loading = false;
    });
  }

  insert(List row) {}

  update() {}

  delete() {}

  sugestionList(index) {
    return database.map<String>((e) => e[index].toString()).toList();
  }
}
