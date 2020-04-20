import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit/edit_page.dart';


class DetailsPage extends StatefulWidget {
  final data;

  DetailsPage(this.data);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                            data: widget.data,
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
                  'assets/melville/${widget.data[6]}.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            labelDescription(_cabecalho[0]),
            label(widget.data[0]),
            labelDescription(_cabecalho[1]),
            label(widget.data[1]),
            labelDescription(_cabecalho[2]),
            label(widget.data[2]),
            labelDescription(_cabecalho[3]),
            label(widget.data[3]),
            labelDescription(_cabecalho[4]),
            label(widget.data[4]),
            labelDescription(_cabecalho[5]),
            label(widget.data[5]),
            labelDescription(_cabecalho[6]),
            label(widget.data[6]),
          ],
        ),
      ),
    );
  }

  Widget labelDescription(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value!=null?value.toString():'',
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
        value!=null?value.toString():'',
        textAlign: TextAlign.center,
      ),
    );
  }
}
