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

    print(init);
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
    return SafeArea(
      child: PopupMenuButton(
        tooltip: 'Ordenar',
//        initialValue: widget.init,
        icon: Icon(Icons.filter_list),
        itemBuilder: (context) {
//        return widget.values
//            .map((value) => PopupMenuItem(
//                  child: Text(value.toString()),
//                  value: value.toString(),
//                ))
//            .toList();

          return List.generate(
              widget.filters.length,
              (index) => PopupMenuItem(
                    value: widget.keys[index].toString(),
                    child: Text(widget.values[index].toString()),
                    textStyle: TextStyle(
                        color: widget.keys[index].toString() == widget.init
                            ? Colors.green
                            : Colors.black),
                  ));
        },
        onSelected: (value) {
          var provider = Provider.of<ProviderDatabase>(context, listen: false);

          if (provider.filter == value) {
            provider.filterASC = !provider.filterASC;

            provider.orderByList(value, provider.filterASC);
          } else {
            provider.filterASC = true;
            provider.orderByList(value, provider.filterASC);
            provider.filter = value;
          }
        },
      ),
    );
  }
}
