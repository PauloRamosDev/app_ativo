import 'package:appativo/edit/widget_image.dart';
import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit/edit_page.dart';
import 'models/model_data.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  Data data;

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
              onPressed: () async {
                var registro = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditPage(
                              data: widget.data,
                            )));

                if(registro!=null){
                  setState(() {
                    widget.data = registro;
                  });
                }

              },

          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 250,
                child: ImageView(widget.data.fieldSeven),
              ),
            ),
            labelDescription(_cabecalho.fieldOne),
            label(widget.data.fieldOne),
            labelDescription(_cabecalho.fieldTwo),
            label(widget.data.fieldTwo),
            labelDescription(_cabecalho.fieldTree),
            label(widget.data.fieldTree),
            labelDescription(_cabecalho.fieldFour),
            label(widget.data.fieldFour),
            labelDescription(_cabecalho.fieldFive),
            label(widget.data.fieldFive),
            labelDescription(_cabecalho.fieldSix),
            label(widget.data.fieldSix),
            labelDescription(_cabecalho.fieldSeven),
            label(widget.data.fieldSeven),
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
