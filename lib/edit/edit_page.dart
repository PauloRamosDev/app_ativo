import 'package:appativo/models/model_data.dart';
import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'bloc_edit.dart';

class EditPage extends StatefulWidget {
  final Data data;

  EditPage({this.data});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  BlocEdit bloc;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    bloc = BlocEdit(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _dataBase = Provider.of<ProviderDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.tipo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                readOnly: false,
                child: Column(
                  children: <Widget>[
                    _editText(_dataBase.cabecalho.fieldOne, onChanged: (value) {
                      bloc.patrimonio = value;
                    },
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldOne
                            : '',
                        sugetionList: _dataBase.sugestionList(1)),
                    _editText(_dataBase.cabecalho.fieldTwo, onChanged: (value) {
                      bloc.descricao = value;
                    },
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldTwo
                            : '',
                        sugetionList: _dataBase.sugestionList(2)),
                    _editText(_dataBase.cabecalho.fieldTree,
                        onChanged: (value) {
                      bloc.marca = value;
                    },
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldTree
                            : '',
                        sugetionList: _dataBase.sugestionList(3)),
                    _editText(_dataBase.cabecalho.fieldFour,
                        onChanged: (value) {
                      bloc.modelo = value;
                    },
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldFour
                            : ''),
                    _editText(_dataBase.cabecalho.fieldFive,
                        onChanged: (value) {
                      bloc.medidas = value;
                    },
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldFive
                            : ''),
                    _editText(_dataBase.cabecalho.fieldSix, onChanged: (value) {
                      bloc.localizacao = value;
                    },
                        sugetionList: _dataBase.sugestionList(6),
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldSix
                            : ''),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () async{
                  var commit = await bloc.commit(context);



                  print(commit);
                },
                child: Text(bloc.tipo == 'Novo Ativo'
                    ? 'Adicionar'
                    : 'Salvar Alterações'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _editText(label,
      {ValueChanged onChanged,
      initialValue,
      List<String> sugetionList = const [],
      textFieldConfiguration = const TextFieldConfiguration()}) {
    return FormBuilderTypeAhead(
      attribute: label,
      onChanged: onChanged,
      noItemsFoundBuilder: (_) => null,
      decoration: InputDecoration(
        labelText: label.toString(),
      ),
      initialValue: initialValue != null ? initialValue.toString() : '',
      textFieldConfiguration: textFieldConfiguration,
      itemBuilder: (context, input) {
        return ListTile(
          title: Text(input),
        );
      },
      selectionToTextTransformer: (value) => value,
      suggestionsCallback: (query) {
        print('suggestionsCallback:  $query');

        if (query.length != 0) {
          var lowercaseQuery = query.toLowerCase();

          //TODO: tenho que deixar aqui a lista global com o seu index
          return sugetionList.where((value) {
            return value.toLowerCase().contains(lowercaseQuery);
          }).toList(growable: false)
            ..sort((a, b) => a
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
        } else {
          return sugetionList;
        }
      },
    );
  }
}
