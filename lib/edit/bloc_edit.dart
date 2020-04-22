import 'package:appativo/models/model_data.dart';
import 'package:appativo/provider/provider_database.dart';
import 'package:provider/provider.dart';

class BlocEdit {
  final Data data;
  Data registro;
  String tipo;
  String patrimonio = '';
  String descricao = '';
  String localizacao = '';
  String marca = '';
  String modelo = '';
  String medidas = '';
  String numeroFoto;
  String verificado = '';

  BlocEdit(this.data) {
    if (data != null) {
      print(data.toJson());
      this.tipo = 'Editar Ativo';

      patrimonio = data.fieldOne;
      descricao = data.fieldTwo;
      marca = data.fieldTree;
      modelo = data.fieldFour;
      medidas = data.fieldFive;
      localizacao = data.fieldSix;
      numeroFoto = data.fieldSeven;
      verificado = data.fieldEigth;
    } else {
      this.tipo = 'Novo Ativo';
    }

    print(tipo);
  }

  bool _alterado() {
    var a = data.fieldOne != patrimonio;
    var b = data.fieldTwo != descricao;
    var c = data.fieldTree != marca;
    var d = data.fieldFour != modelo;
    var e = data.fieldFive != medidas;
    var f = data.fieldSix != localizacao;
    var g = data.fieldSeven != numeroFoto;
    var h = data.fieldEigth != verificado;

    return a || b || c || d || e || f || g || h;
  }

  _updateAtivo(context) async {
    if (_alterado()) {
      //realizar alterações e salvar dados

      var provider = Provider.of<ProviderDatabase>(context, listen: false);

      if (patrimonio.isNotEmpty &&
          descricao.isNotEmpty &&
          localizacao.isNotEmpty) {
        registro = Data(
            id: data.id,
            fieldOne: patrimonio,
            fieldTwo: descricao,
            fieldSix: localizacao,
            fieldTree: marca,
            fieldFour: modelo,
            fieldFive: medidas,
            fieldSeven: numeroFoto ?? data.fieldSeven);
        return await provider.update(registro);
      }
      return null;
    } else {
      print('sem alterações');
      return true;
    }

    //commitar alteracao;
  }

  _insertAtivo(context) async {
    //validar os campos e salvar os dados
    var provider = Provider.of<ProviderDatabase>(context, listen: false);

    if (patrimonio.isNotEmpty &&
        descricao.isNotEmpty &&
        localizacao.isNotEmpty) {
      registro = Data(
        fieldOne: patrimonio,
        fieldTwo: descricao,
        fieldSix: localizacao,
        fieldTree: marca,
        fieldFour: modelo,
        fieldFive: medidas,
        fieldSeven: numeroFoto ?? 'INACESSÍVEL',
      );

      return await provider.insert(registro);
    }
    return null;
  }

  commit(context) {
    if (tipo == 'Novo Ativo') {
      return _insertAtivo(context);
    } else {
      return _updateAtivo(context);
    }
  }

  @override
  String toString() {
    return 'BlocEdicao => tipo: $tipo, patrimonio: $patrimonio, descricao: $descricao, localização: $localizacao';
  }
}
