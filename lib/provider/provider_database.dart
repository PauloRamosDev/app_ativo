import 'package:appativo/sheet.dart';
import 'package:flutter/cupertino.dart';

class ProviderDatabase with ChangeNotifier{
  List<dynamic> database = [];
  bool carregado = false;

  ProviderDatabase() {
    getDataBase();
  }

  getDataBase() async {
    database = await Sheet(null).getDataBase();
    carregado = true;
    print(carregado);

    notifyListeners();
  }

  get cabecalho => database[0];

  insert(List row) {}

  update() {}

  delete() {}

  sugestionList(index) {
    return database.map<String>((e) => e[index].toString()).toList();
  }
}
