import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final List filters;
  final BuildContext context;

  OrderList(this.filters, this.context){
    filters.removeAt(0);
  }

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(100, 50),
      icon: Icon(Icons.filter_list),
      itemBuilder: (context) {
        return List.generate(
            widget.filters.length,
            (index) => PopupMenuItem(
                value: widget.filters[index].toString(),
                child: Text(widget.filters[index].toString())));
      },
      onSelected: (value) =>
          Provider.of<ProviderDatabase>(context, listen: false)
              .orderByList(value),
    );
  }
}
