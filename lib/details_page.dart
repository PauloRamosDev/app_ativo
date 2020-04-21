import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit/edit_page.dart';
import 'models/model_data.dart';

class DetailsPage extends StatelessWidget {
  final Data data;

  DetailsPage(this.data);

  @override
  Widget build(BuildContext context) {
    var _cabecalho = Provider.of<ProviderDatabase>(context).cabecalho;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditPage(
                            data: data,
                          ))))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 250,
                child: Image.asset(
                  'assets/melville/${data.fieldSeven}.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            labelDescription(_cabecalho.fieldOne),
            label(data.fieldOne),
            labelDescription(_cabecalho.fieldTwo),
            label(data.fieldTwo),
            labelDescription(_cabecalho.fieldTree),
            label(data.fieldTree),
            labelDescription(_cabecalho.fieldFour),
            label(data.fieldFour),
            labelDescription(_cabecalho.fieldFive),
            label(data.fieldFive),
            labelDescription(_cabecalho.fieldSix),
            label(data.fieldSix),
            labelDescription(_cabecalho.fieldSeven),
            label(data.fieldSeven),
          ],
        ),
      ),
    );
  }

  Widget labelDescription(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value != null ? value.toString() : '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget label(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value != null ? value.toString() : '',
        textAlign: TextAlign.center,
      ),
    );
  }
}
