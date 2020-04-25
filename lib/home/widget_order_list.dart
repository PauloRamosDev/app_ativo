import 'package:appativo/provider/provider_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final Map filters;
  final BuildContext context;
  final List keys = [];
  final List values = [];
  final init;

  OrderList(this.filters, this.context, {this.init}) {
    if (filters != null) {
      filters.remove('id');

      keys.addAll(filters.keys.toList());
      values.addAll(filters.values.toList());
    }
  }

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Ordenar',
      initialValue: widget.init,
      icon: Icon(Icons.filter_list),
      itemBuilder: (context) {
        return List.generate(
            widget.filters.length,
            (index) => PopupMenuItem(
                value: index == 0 ? 'id' : widget.keys[index].toString(),
                child: Text(widget.values[index].toString())));
      },
      onSelected: (value) {
        var provider = Provider.of<ProviderDatabase>(context, listen: false);

        if (provider.filter == value) {
          provider.filterASC = !provider.filterASC;

          provider.orderByList(value, provider.filterASC);
        } else {
          provider.orderByList(value, provider.filterASC);
          provider.filter = value;
        }
      },
    );
  }
}
