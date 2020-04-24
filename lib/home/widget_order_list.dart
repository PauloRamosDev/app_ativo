import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    var cabecalho = Provider.of<ProviderDatabase>(context).cabecalho.toJson().values.toList();

    return PopupMenuButton(
        offset: Offset(100, 50),
        icon: Icon(Icons.filter_list),
        itemBuilder: (context) {
          return List.generate(cabecalho.length,
              (index) => PopupMenuItem(child: Text(cabecalho[index].toString())));
        });
  }
}
