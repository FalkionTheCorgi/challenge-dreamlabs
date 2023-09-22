import 'dart:convert';
import 'package:dreamlabs_challenge/api/data/JsonResponse.dart';
import 'package:http/http.dart' as http;

import 'data/Message.dart';

class Api {
  final link = 'jsonplaceholder.typicode.com';
  static final Api _instance = Api._internal();

  Api._internal();

  static Api get instance => _instance;

  Future<dynamic> getJsonResponse() async {
    final url = Uri.https(link, '/posts');

    final response = await http.get(url);

    final parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final response = JsonResponse.fromJson(parsed);
      return response;
    } else {
      final responseError = Message(message: "Erro desconhecido");
      return responseError;
    }

  }

}