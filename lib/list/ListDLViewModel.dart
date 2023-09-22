import 'package:dreamlabs_challenge/database/DB.dart';
import 'package:dreamlabs_challenge/database/JsonDataRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api.dart';
import '../api/data/JsonResponse.dart';
import '../api/data/Message.dart';

final listDLViewModel = ChangeNotifierProvider((ref) => ListDLViewModel());

class ListDLViewModel extends ChangeNotifier{

  int page = 1;
  final List<JsonResponseData> list = [];
  final List<JsonResponseData> listLoad = [];
  final listEmpty = JsonResponseData(userId: 0, id: 0, title: '', body: '');

  void refreshPage(){
    page = 1;
    list.clear();
    listLoad.clear();
    notifyListeners();
  }

  Future<void> getJson() async {

    final db = await DB.instance.database;
    List jsonData = await db.query('json_data');

    if(jsonData.isEmpty) {
      final response = await Api.instance.getJsonResponse();

      if (response is JsonResponse) {
        for (var indice = 0; indice <
            response.list.length; indice++) {
          list.add(response.list[indice]);
        }

        await fillListLoad(response.list);

      } else if (response is Message) {
        listLoad.add(listEmpty);

      }
    } else {

      for (var indice = 0; indice <
          jsonData.length; indice++) {
        list.add(
          JsonResponseData(
              userId: jsonData[indice]['user_id'],
              id: jsonData[indice]['id_json'],
              title: jsonData[indice]['title'],
              body: jsonData[indice]['body']
          )
        );
      }

      await fillListLoad(list);

    }
  }

  fillListLoad(List<JsonResponseData> list) async {

    if (page <= 5) {

      await Future.delayed(const Duration(seconds: 2));

      for (var indice = listLoad.length; indice <
          20 * page; indice++) {
        listLoad.add(list[indice]);
      }

      page++;

      notifyListeners();


    }
  }

}