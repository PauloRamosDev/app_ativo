import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import 'models/model_data.dart';

class Sheet {
  SpreadsheetTable _sheet;
  SpreadsheetDecoder _decoder;

  Sheet();

//  var _maxCollumn;
//  var _maxRows;

  initialization() async {
    _decoder = await _decoderModel();
    _sheet = _decoder.tables[_decoder.tables.keys.first];
  }

  Future<SpreadsheetDecoder> _decoderModel() async {
    var bytesData = await rootBundle.load('assets/xlsx/model.xlsx');
    return SpreadsheetDecoder.decodeBytes(bytesData.buffer.asUint8List(),
        update: true);
  }

  insertRowDataBase(List<dynamic> data) {
    var maxRowsOld = _sheet.maxRows;
    print('pre insert maxOld ' + maxRowsOld.toString());

    _decoder.insertRow(_sheet.name, _sheet.maxRows);

    for (var pos = 0; pos < data.length; pos++) {
      _decoder.updateCell(
          _sheet.name, pos, (_sheet.maxRows - 1), data[pos] ?? '');
    }

    print('sheet max ' + _sheet.maxRows.toString());

    return maxRowsOld < _sheet.maxRows;
  }

  _insertCollumnDataBase(int maxCollumn) {
    List.generate(
        maxCollumn, (index) => _decoder.insertColumn(_sheet.name, index));

    print(_sheet.maxCols);
  }

  _createOutputFile() async {
    var path = (await getExternalStorageDirectory()).path + '/Output Ativo Fixo.xlsx';

    return File(join(path))
      ..create(recursive: true)
      ..writeAsBytes(_decoder.encode());
  }

  Future<List<dynamic>> getDataBase() async {
    //colunas = 7
    //linhas = 379

    var bytesData = await rootBundle.load('assets/xlsx/Melville.xlsx');
    var decoder = SpreadsheetDecoder.decodeBytes(bytesData.buffer.asUint8List(),
        update: true);

    return decoder.tables[decoder.tables.keys.first].rows;
  }

  createOutput(List<Data> ativos, {Data cabecalho}) async {
    if (ativos.length > 0) {
      _insertCollumnDataBase(ativos[0].toJson().length);
    }

    if (cabecalho != null)
      insertRowDataBase(cabecalho.toJson().values.toList());

    for (var i = 0; i < ativos.length; ++i) {
      Data ativo = ativos[i];
      insertRowDataBase(ativo.toJson().values.toList());
    }

    printSheet();

    _createOutputFile();
  }

  printSheet() async {
//    SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(
//        (await File(pathSheet).readAsBytes()),
//        update: true);

    print("************************************************************");
    for (var table in _decoder.tables.keys) {
      print(table);
      print(_decoder.tables[table].maxCols);
      print(_decoder.tables[table].maxRows);
      for (var row in _decoder.tables[table].rows) {
        print("$row");
      }
    }
    print("************************************************************");
  }

}
