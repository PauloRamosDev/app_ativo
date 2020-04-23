import 'package:appativo/details_page.dart';
import 'package:appativo/models/model_data.dart';
import 'package:appativo/provider/provider_database.dart';
import 'package:appativo/sheet.dart';
import 'package:appativo/sqlite/database_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit/edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                sheet.createOutput(database, cabecalho: cabecalho);
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(),
                      );
                    });
              }),
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
    var listReversed = list.reversed.toList();
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          if (list.length > 0) {
            var data = listReversed[index];
            return ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetailsPage(data))),
              title: Text(data.fieldTwo),
              subtitle: Text(data.fieldSix),
              leading: Text(data.fieldOne),
            );
          } else {
            return Container();
          }
        });
  }
}
