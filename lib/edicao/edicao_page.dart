import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'bloc_edicao.dart';

class EdicaoPage extends StatefulWidget {
  final List data;

  EdicaoPage({this.data});

  @override
  _EdicaoPageState createState() => _EdicaoPageState();
}

class _EdicaoPageState extends State<EdicaoPage> {
  BlocEdicao bloc;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    bloc = BlocEdicao(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    FormBuilderTypeAhead(
                      attribute: 'Patrimonio',
                      onChanged: bloc.setPatrimonio,
                      noItemsFoundBuilder: (_) => null,
                      decoration: InputDecoration(
                        labelText: "Patrimonio",
                      ),
                      initialValue: bloc.patrimonio ?? '',
                      textFieldConfiguration: TextFieldConfiguration(
                          keyboardType: TextInputType.number),
                      itemBuilder: (context, input) {
                        return ListTile(
                          title: Text(input),
                          subtitle: Text('coco'),
                        );
                      },
                      selectionToTextTransformer: (value) => value,
                      suggestionsCallback: (query) {
                        print('suggestionsCallback:  $query');

                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();

                          //TODO: tenho que deixar aqui a lista global com o seu index
                          return bloc.dataList.where((value) {
                            return value.toLowerCase().contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return bloc.dataList;
                        }
                      },
                    ),
                    FormBuilderTypeAhead(
                      attribute: 'descricao',
                      onChanged: bloc.setDescricao,
                      noItemsFoundBuilder: (_) => null,
                      decoration: InputDecoration(
                        labelText: "Descrição do item",
                      ),
                      initialValue: bloc.descricao ?? '',
                      textFieldConfiguration: TextFieldConfiguration(
//                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          minLines: 1),
                      itemBuilder: (context, input) {
                        return ListTile(
                          title: Text(input),
                        );
                      },
                      selectionToTextTransformer: (value) => value,
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return bloc.dataList.where((value) {
                            return value.toLowerCase().contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return bloc.dataList;
                        }
                      },
                    ),
                    FormBuilderTypeAhead(
                      attribute: 'localizacao',
                      onChanged: bloc.setLocalizacao,
                      noItemsFoundBuilder: (_) => null,
                      decoration: InputDecoration(
                        labelText: "Localização",
                      ),
                      initialValue: bloc.localizacao ?? '',
                      textFieldConfiguration: TextFieldConfiguration(),
                      itemBuilder: (context, input) {
                        return ListTile(
                          title: Text(input),
                        );
                      },
                      selectionToTextTransformer: (value) => value,
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return bloc.dataList.where((value) {
                            return value.toLowerCase().contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return bloc.dataList;
                        }
                      },
                    ),
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
}
