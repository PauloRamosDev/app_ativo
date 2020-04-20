import 'package:appativo/provider/provider_database.dart';
import 'package:provider/provider.dart';

class BlocEdit {
  BlocEdit(List data) {
    if (data != null) {
      this.tipo = 'Editar Ativo';
      this.dataList = data.map<String>((e) => e.toString()).toList();
      this.patrimonio = dataList[0];
      this.descricao = dataList[1];
      this.localizacao = dataList[5];
    } else {
      tipo = 'Novo Ativo';
    }
  }

  List<String> dataList = [];
  String patrimonio;
  String descricao;
  String localizacao;
  String tipo;

  setPatrimonio(value) => this.patrimonio = value;

  setDescricao(value) => this.descricao = value;

  setLocalizacao(value) => this.localizacao = value;

  bool _alterado() {
    var a = patrimonio != dataList[0];
    var b = descricao != dataList[1];
    var c = localizacao != dataList[5];

    return a || b || c;
  }

  _salvarAlteracao(context, data) {
    if (_alterado()) {
      //realizar alterações e salvar dados

      print(toString());
    } else {
      print('sem alterações');
      return true;
    }

    //commitar alteracao;
  }

  _novoAtivo(context, data) {
    //validar os campos e salvar os dados

    Provider.of<ProviderDatabase>(context, listen: false).insert(data);

    print(toString());
    return true;
  }

  commit(context) {
    if (tipo == 'Novo Ativo') {
      return _novoAtivo(context,
          ['99999', 'descriçaõ do item', 'localidade', '1', '2', '3', null]);
    } else {
      return _salvarAlteracao(context, dataList);
    }
  }

  @override
  String toString() {
    //alterado();
    return 'BlocEdicao => tipo: $tipo, patrimonio: $patrimonio, descricao: $descricao, localização: $localizacao';
  }
}
