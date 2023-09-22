import 'package:dreamlabs_challenge/database/data/JsonData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'DB.dart';

final jsonDataRepository = ChangeNotifierProvider((ref) => JsonDataRepository());

class JsonDataRepository extends ChangeNotifier {

  late Database db;
  final List<JsonData> _jsonData = [];

  List<JsonData> get jsonData => _jsonData;

  JsonDataRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getJsonData();
  }

  _getJsonData() async {
    db = await DB.instance.database;
    List jsonData = await db.query('json_data');

    for (var element in jsonData) {
      _jsonData.add(JsonData(
        id: element['id'],
        idJson: element['id_json'],
        userId: element['user_id'],
        title: element['title'],
        body: element['body']
      ));
    }
    notifyListeners();
  }

  addItems(List<JsonData> data) async {

    db = await DB.instance.database;

    for(var element in data) {
      await db.insert(
          'json_data',
          {
            'id_json': element.idJson,
            'user_id': element.userId,
            'title': element.title,
            'body': element.body
          },
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    _jsonData.clear();

    _getJsonData();

    notifyListeners();

  }

}