import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class Sheet {
  final pathSheet;

  Sheet(this.pathSheet);

  /// pathSheet de teste
  /// data/user/0/com.appativo/app_flutter/test.xlsx

  _decoder() async {
    var bytesData = await rootBundle.load('assets/xlsx/model.xlsx');
    return SpreadsheetDecoder.decodeBytes(bytesData.buffer.asUint8List(),
        update: true);
  }

  printSheet() async {
    SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(
        (await File(pathSheet).readAsBytes()),
        update: true);

    print("************************************************************");
    for (var table in decoder.tables.keys) {
      print(table);
      print(decoder.tables[table].maxCols);
      print(decoder.tables[table].maxRows);
      for (var row in decoder.tables[table].rows) {
        print("$row");
      }
    }
    print("************************************************************");
  }

  insertDataSheet(List listData) async {
    var column = 0;
    var rows = listData?.length ?? 0;
    SpreadsheetDecoder decoder = await _decoder();
    var sheet = decoder.tables.keys.first;

    if (rows > 0) {
      decoder.insertColumn(sheet, column);
      for (var i = 0; i < rows; i++) {
        decoder.insertRow(sheet, i);
        decoder.updateCell(sheet, column, i, listData[i]);
      }
    }

    File(join(pathSheet))
      ..createSync(recursive: true)
      ..writeAsBytesSync(decoder.encode());

    printSheet();
  }

  Future<List<dynamic>> getDataBase() async {
    //colunas = 7
    //linhas = 379

    var bytesData = await rootBundle.load('assets/xlsx/Melville.xlsx');
    var decoder = SpreadsheetDecoder.decodeBytes(bytesData.buffer.asUint8List(),
        update: true);

    return decoder.tables[decoder.tables.keys.first].rows;
  }
}
