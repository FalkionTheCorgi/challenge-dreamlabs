
class JsonResponse{

  List<JsonResponseData> list;

  JsonResponse({required this.list});

  factory JsonResponse.fromJson(List<dynamic> json) {

    List<JsonResponseData> responseParsed = json.map((item) => JsonResponseData.fromJson(item)).toList();
    
    return JsonResponse(list: responseParsed);
    
  }

}

class JsonResponseData{

  final int userId;
  final int id;
  final String title;
  final String body;

  JsonResponseData({required this.userId, required this.id, required this.title, required this.body});

  factory JsonResponseData.fromJson(Map<String, dynamic> json) {
    return JsonResponseData(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String
    );
  }

}