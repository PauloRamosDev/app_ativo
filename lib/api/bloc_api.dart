import 'dart:io';

import 'package:appativo/api/api.dart';
import 'package:appativo/sqlite/database_dao.dart';
import 'package:flutter/cupertino.dart';

class BlocApi with ChangeNotifier {

  int total = 0;
  int sent = 0;
  int toSend = 0;
  bool loading = false;

  refresh() async {

    total = await DatabaseDAO().count();
    sent = await DatabaseDAO().countSent();
    toSend = await DatabaseDAO().countToSend();

    notifyListeners();
  }

  submit() async {
    if (!loading) {
      refresh();
      loading = true;

      var api = Api();

      var listToSend = await DatabaseDAO().findToSend();

      for (var data in listToSend) {


        var isfile = await File(data.fieldSeven).exists();

        if(isfile){

          print(isfile);
          var path = await api.uploadFile(data.fieldSeven).catchError((error) {

            print('cath time out');
            loading = false;
            refresh();
          });

          data.fieldSeven = path.data;
        }

        var response = await api.insertAtivo(data).catchError((error) {
          loading = false;
          refresh();
        });

        if (response == 201) {
          data.sent = 1;
          DatabaseDAO().update(data, data.id);

          refresh();
        }
      }
      loading = false;
      refresh();
    }
  }

}
