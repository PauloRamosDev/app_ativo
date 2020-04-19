import 'package:flutter/material.dart';

import 'edicao/edicao_page.dart';

class DetalhesPage extends StatefulWidget {
  final data;

  DetalhesPage(this.data);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EdicaoPage(
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
            Text('DESCRIÇÃO DO ITEM'),
            Text(widget.data[1]),
            Text('MARCA'),
            Text(widget.data[2]),
            Text('LOCALIZAÇÃO'),
            Text(widget.data[5]),
          ],
        ),
      ),
    );
  }
}
