import 'package:appativo/detalhes_page.dart';
import 'package:appativo/sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var list = [];

  @override
  void initState() {
    Sheet(null).getDataBase().then((value) {
      list = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de ativos'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            if (list.length > 0)
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetalhesPage(list[index]))),
                title: Text(list[index][1]),
                subtitle: Text(list[index][5]),
                leading: Text(list[index][0].toString()),
              );

            return Container();
          }),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {}),
    );
  }
}
