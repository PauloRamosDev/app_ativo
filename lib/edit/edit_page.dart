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
  var provider;
  BlocEdit bloc;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    bloc = BlocEdit(widget.data);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<ProviderDatabase>(context);
    super.didChangeDependencies();
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
                    editText(
                      provider.cabecalho.fieldOne,
                      readOnly: bloc.tipo == 'Editar Ativo',
                      onChanged: (value) => bloc.patrimonio = value,
                      sugetionList: provider.sugestionList(1),
                      initialValue: bloc.tipo == 'Editar Ativo'
                          ? widget.data.fieldOne
                          : '',
                    ),
                    editText(
                      provider.cabecalho.fieldTwo,
                      onChanged: (value) => bloc.descricao = value,
                      sugetionList: provider.sugestionList(2),
                      initialValue: bloc.tipo == 'Editar Ativo'
                          ? widget.data.fieldTwo
                          : '',
                    ),
                    editText(
                      provider.cabecalho.fieldTree,
                      sugetionList: provider.sugestionList(3),
                      onChanged: (value) => bloc.marca = value,
                      initialValue: bloc.tipo == 'Editar Ativo'
                          ? widget.data.fieldTree
                          : '',
                    ),
                    editText(provider.cabecalho.fieldFour,
                        onChanged: (value) => bloc.modelo = value,
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldFour
                            : ''),
                    editText(provider.cabecalho.fieldFive,
                        onChanged: (value) => bloc.medidas = value,
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldFive
                            : ''),
                    editText(provider.cabecalho.fieldSix,
                        onChanged: (value) => bloc.localizacao = value,
                        sugetionList: provider.sugestionList(6),
                        initialValue: bloc.tipo == 'Editar Ativo'
                            ? widget.data.fieldSix
                            : ''),


                  ],
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  var commit = await bloc.commit(context);

                  print(commit);



                  commit != null ? Navigator.of(context).pop(bloc.registro) : print(commit);
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

  Widget editText(label,
      {ValueChanged onChanged,
      initialValue,
      readOnly = false,
      List<String> sugetionList = const [],
      textFieldConfiguration = const TextFieldConfiguration(
        textCapitalization: TextCapitalization.characters,
      )}) {
    return FormBuilderTypeAhead(
      readOnly: readOnly,
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
