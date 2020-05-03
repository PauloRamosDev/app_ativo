import 'package:appativo/api/bloc_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendToApi extends StatefulWidget {
  @override
  _SendToApiState createState() => _SendToApiState();
}

class _SendToApiState extends State<SendToApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status de transmissão'),
      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Consumer<BlocApi>(
        builder: (context, value, child) {
          value.refresh();
          return Container(
            height: 250,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _customText('Total de Dados ' + value.total.toString()),
                _customText('Dados sincronizados ' + value.sent.toString()),
                _customText('Dados para enviar ' + value.toSend.toString()),
//                Text(' Total de Dados ' + value.total.toString()),
//                Text(' Dados sincronizados ' + value.sent.toString()),
//                Text(' Dados para enviar ' + value.toSend.toString()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        value.submit();
                      },
                      child: value.loading
                          ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                          )
                          : Text('Enviar dados')),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _customText(texto) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
