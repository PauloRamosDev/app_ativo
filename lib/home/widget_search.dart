import 'package:appativo/models/model_data.dart';
import 'package:flutter/material.dart';

class DataSeach extends SearchDelegate<Data> {
  final List<Data> listSearch;
  final recents;

  DataSeach(this.listSearch, {this.recents = const <Data>[]});

  //implementar um recentes?

  @override
  List<Widget> buildActions(BuildContext context) {
    //Botoes de ação
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Data> suggestionsList = query.isEmpty
        ? listSearch
        : listSearch.where((e) => e.fieldOne.contains(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionsList[index].fieldOne;
          close(context, suggestionsList[index]);
          showResults(context);
        },
        leading: Text(suggestionsList[index].fieldOne),
        title: Text(suggestionsList[index].fieldTwo),
//        title: RichText(
//            text: TextSpan(
//                style: TextStyle(color: Colors.green),
//                text: suggestionsList[index].fieldOne.substring(0, query.length),
//                children: [
//              TextSpan(
//                text: suggestionsList[index].fieldOne.substring(query.length),
//                style:
//                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//              )
//            ])),
      ),
      itemCount: suggestionsList.length,
    );
  }
}
