import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'bloc_edit.dart';

class EditPage extends StatefulWidget {
  final List data;

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
                    _editText(_dataBase.cabecalho[0],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[0]:'',sugetionList: _dataBase.sugestionList(0)),
                    _editText(_dataBase.cabecalho[1],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[1]:'',sugetionList: _dataBase.sugestionList(1)),
                    _editText(_dataBase.cabecalho[2],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[2]:''),
                    _editText(_dataBase.cabecalho[3],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[3]:''),
                    _editText(_dataBase.cabecalho[4],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[4]:''),
                    _editText(_dataBase.cabecalho[5],
                        onChanged: (value) => print(value),
                        initialValue: bloc.tipo =='Editar Ativo'? widget.data[5]:''),
//                    FormBuilderTypeAhead(
//                      attribute: 'Patrimonio',
//                      onChanged: bloc.setPatrimonio,
//                      noItemsFoundBuilder: (_) => null,
//                      decoration: InputDecoration(
//                        labelText: 'Patrimonio',
//                      ),
//                      initialValue: bloc.patrimonio ?? '',
//                      textFieldConfiguration: TextFieldConfiguration(
//                          keyboardType: TextInputType.number),
//                      itemBuilder: (context, input) {
//                        return ListTile(
//                          title: Text(input),
//                        );
//                      },
//                      selectionToTextTransformer: (value) => value,
//                      suggestionsCallback: (query) {
//                        print('suggestionsCallback:  $query');
//
//                        if (query.length != 0) {
//                          var lowercaseQuery = query.toLowerCase();
//
//                          //TODO: tenho que deixar aqui a lista global com o seu index
//                          return bloc.dataList.where((value) {
//                            return value.toLowerCase().contains(lowercaseQuery);
//                          }).toList(growable: false)
//                            ..sort((a, b) => a
//                                .toLowerCase()
//                                .indexOf(lowercaseQuery)
//                                .compareTo(
//                                    b.toLowerCase().indexOf(lowercaseQuery)));
//                        } else {
//                          return bloc.dataList;
//                        }
//                      },
//                    ),
//                    FormBuilderTypeAhead(
//                      attribute: 'descricao',
//                      onChanged: bloc.setDescricao,
//                      noItemsFoundBuilder: (_) => null,
//                      decoration: InputDecoration(
//                        labelText: "Descrição do item",
//                      ),
//                      initialValue: bloc.descricao ?? '',
//                      textFieldConfiguration: TextFieldConfiguration(
////                          keyboardType: TextInputType.multiline,
//                          maxLines: 4,
//                          minLines: 1),
//                      itemBuilder: (context, input) {
//                        return ListTile(
//                          title: Text(input),
//                        );
//                      },
//                      selectionToTextTransformer: (value) => value,
//                      suggestionsCallback: (query) {
//                        if (query.length != 0) {
//                          var lowercaseQuery = query.toLowerCase();
//                          return bloc.dataList.where((value) {
//                            return value.toLowerCase().contains(lowercaseQuery);
//                          }).toList(growable: false)
//                            ..sort((a, b) => a
//                                .toLowerCase()
//                                .indexOf(lowercaseQuery)
//                                .compareTo(
//                                    b.toLowerCase().indexOf(lowercaseQuery)));
//                        } else {
//                          return bloc.dataList;
//                        }
//                      },
//                    ),
//                    FormBuilderTypeAhead(
//                      attribute: 'localizacao',
//                      onChanged: bloc.setLocalizacao,
//                      noItemsFoundBuilder: (_) => null,
//                      decoration: InputDecoration(
//                        labelText: "Localização",
//                      ),
//                      initialValue: bloc.localizacao ?? '',
//                      textFieldConfiguration: TextFieldConfiguration(),
//                      itemBuilder: (context, input) {
//                        return ListTile(
//                          title: Text(input),
//                        );
//                      },
//                      selectionToTextTransformer: (value) => value,
//                      suggestionsCallback: (query) {
//                        if (query.length != 0) {
//                          var lowercaseQuery = query.toLowerCase();
//                          return bloc.dataList.where((value) {
//                            return value.toLowerCase().contains(lowercaseQuery);
//                          }).toList(growable: false)
//                            ..sort((a, b) => a
//                                .toLowerCase()
//                                .indexOf(lowercaseQuery)
//                                .compareTo(
//                                    b.toLowerCase().indexOf(lowercaseQuery)));
//                        } else {
//                          return bloc.dataList;
//                        }
//                      },
//                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  bloc.commit();
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

  _editText(label,
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
