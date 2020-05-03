import 'dart:io';

import 'package:appativo/api/api.dart';
import 'package:appativo/api/send_api.dart';
import 'package:appativo/details_page.dart';
import 'package:appativo/home/widget_order_list.dart';
import 'package:appativo/models/model_data.dart';
import 'package:appativo/provider/provider_database.dart';
import 'package:appativo/home/widget_search.dart';
import 'package:appativo/sheet.dart';
import 'package:appativo/sqlite/database_dao.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../edit/edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //apiTeste();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDatabase>(context);
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  accountName: Text('App Ativo'),
                  accountEmail: Text('Melville'),
                ),
              ),
              ListTile(
                title: Text('Status'),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SendToApi())),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Lista de ativos'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.insert_drive_file),
              onPressed: () async {
                var sheet = Sheet();
                DatabaseDAO dao = DatabaseDAO();
                await sheet.initialization();

                var cabecalho = await dao.headers();
                var database = await dao.findAll();

                var output =
                    await sheet.createOutput(database, cabecalho: cabecalho);

                OpenFile.open(output.path);
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                var result = await showSearch(
                    context: context,
                    delegate: DataSeach(
                        Provider.of<ProviderDatabase>(context, listen: false)
                            .database));

                print(result);

                if (result != null)
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditPage(data: result)));
              }),
          OrderList(
            provider?.cabecalho?.toJson(),
            context,
            init: provider.filter,
          )
        ],
      ),
      body: _bodyConsumer(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => EditPage()));
          }),
    );
  }

  Widget _bodyConsumer() {
    return Consumer<ProviderDatabase>(
      builder: (context, value, _) {
        if (!value.carregado) {
          print('carregando');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('carregado');
          return _body(context, value.database);
        }
      },
    );
  }

  ListView _body(BuildContext context, List<Data> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          if (list.length > 0) {
            var data = list[index];
            var color = data.fieldEigth == 'SIM' ? Colors.green : null;
            return ListTile(
              onLongPress: () => _dialogEdit(data, context),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetailsPage(data))),
              title: Text(
                data.fieldTwo,
                style: TextStyle(color: color),
              ),
              subtitle: Text(data.fieldSix),
              leading: Text(data.fieldOne),
            );
          } else {
            return Container();
          }
        });
  }

  _dialogEdit(Data data, context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Center(child: Text('Item Encontrado? ')),
              content: Text(
                'Patrimônio: ${data.fieldOne}\n${data.fieldTwo}\nLocalização: ${data.fieldSix}',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    RaisedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('SIM'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        data.fieldEigth = 'SIM';
                        Provider.of<ProviderDatabase>(context, listen: false)
                            .update(data);
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.close),
                      label: Text('NÃO'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        data.fieldEigth = 'NÃO';
                        Provider.of<ProviderDatabase>(context, listen: false)
                            .update(data);
                        Navigator.pop(context);
                      },
                    ),
//                    FlatButton(onPressed: null, child: Text('Voltar'))
                  ],
                )
              ],
            ));
  }
}

void apiTeste() async {
  var datas = await DatabaseDAO().findAll();

  var index = 0;

  for (var data in datas) {
    var foto = await File(data.fieldSeven).exists();

    if (foto) {
      var response = await Api().uploadFile(data.fieldSeven);

      data.fieldSeven = response.data;

      print(response.data);
    }

    var result = await Api().insertAtivo(data.toJson());

    index++;
    print(index);
    print(result);
  }
}
