import 'package:appativo/models/model_data.dart';
import 'package:appativo/sheet.dart';
import 'package:appativo/sqlite/database_dao.dart';
import 'package:flutter/cupertino.dart';

class ProviderDatabase with ChangeNotifier {
  var dao = DatabaseDAO();
  List<Data> database = [];
  bool carregado = false;
  Data cabecalho;
  var filter;
  var filterASC = true;

  ProviderDatabase() {
    _getDataBase();
  }

  insert(Data data) async {
    var insert = await dao.insert(data);

    if (insert > 0) {
      orderByList(filter, filterASC);
      return insert;
    }
    return null;
  }

  update(Data data) async {
    var update = await dao.update(data, data.id);

    if (update > 0) {
      orderByList(filter, filterASC);

      return update;
    }
    return null;
  }

  sugestionList(index) {
    switch (index) {
      case 1:
        {
          return _distinct(database.map<String>((e) => e.fieldOne).toList());
        }
        break;
      case 2:
        {
          return _distinct(database.map<String>((e) => e.fieldTwo).toList());
        }
        break;
      case 3:
        {
          return _distinct(database.map<String>((e) => e.fieldTree).toList());
        }
        break;
      case 4:
        {
          return _distinct(database.map<String>((e) => e.fieldFour).toList());
        }
        break;
      case 5:
        {
          return _distinct(database.map<String>((e) => e.fieldFive).toList());
        }
        break;
      case 6:
        {
          return _distinct(database.map<String>((e) => e.fieldSix).toList());
        }
        break;
      case 7:
        {
          return _distinct(database.map<String>((e) => e.fieldSeven).toList());
        }
        break;
      case 8:
        {
          return _distinct(database.map<String>((e) => e.fieldEigth).toList());
        }
        break;
    }
  }

  orderByList(field, orderBY) async {
    var order = await dao.orderBy(field, order: orderBY ? 'ASC' : 'DESC');
    if (order != null && order.length > 0) {
      database = order;
      notifyListeners();
    }
  }

  _getDataBase() async {
    print('getDataBase');
    if ((await dao.count()) > 0) {
      print('banco de dados já populado');
      database.addAll((await dao.findAll()));
      cabecalho = await dao.headers();
    } else {
      print('populando bd pela primeira vez');
      var base = await Sheet().getDataBase();

      for (var i = 0; i < base.length; ++i) {
        var registro = base[i];

        var data = Data(
          fieldOne: registro[0] != null ? registro[0].toString() : '',
          fieldTwo: registro[1] != null ? registro[1].toString() : '',
          fieldTree: registro[2] != null ? registro[2].toString() : '',
          fieldFour: registro[3] != null ? registro[3].toString() : '',
          fieldFive: registro[4] != null ? registro[4].toString() : '',
          fieldSix: registro[5] != null ? registro[5].toString() : '',
          fieldSeven: registro[6] != null ? registro[6].toString() : '',
          fieldEigth: registro[7] != null ? registro[7].toString() : 'NÃO',
        );

        i == 0 ? await dao.insertHeader(data.toJson()) : await dao.insert(data);
      }
      database.addAll((await dao.findAll()));
      cabecalho = await dao.headers();
    }
    carregado = true;
    notifyListeners();
  }

  _distinct(fullSugestions) {
    var distinct = <String>[];

    fullSugestions.forEach((element) {
      if (!distinct.contains(element)) {
        distinct.add(element);
      }
    });

    return distinct;
  }

}
