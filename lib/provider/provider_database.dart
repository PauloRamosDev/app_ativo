import 'package:appativo/sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

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

  insert(List row) async{


//    var result = await Sheet((await getApplicationDocumentsDirectory()).path +'/output.xlsx').insertDataBase(row);

//    print(result.toString());

  }

  update() {}

  delete() {}

  sugestionList(index) {
    return database.map<String>((e) => e[index].toString()).toList();
  }
}
