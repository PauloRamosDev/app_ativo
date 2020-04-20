import 'package:appativo/details_page.dart';
import 'package:appativo/provider/provider_database.dart';
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
      ),
      body: _bodyConsumer(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //Todo: criar pagina para novo ativo
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

  ListView _body(BuildContext context, list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          if (list.length > 0) {

            if(index>0)
            return ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetailsPage(list[index]))),
              title: Text(list[index][1]),
              subtitle: Text(list[index][5]),
              leading: Text(list[index][0].toString()),
            );
            return Container();
          } else {
            return Container();
          }
        });
  }
}
