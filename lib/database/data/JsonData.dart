class JsonData {
  int id;
  int idJson;
  int userId;
  String title;
  String body;

  JsonData(
      {required this.id,
      required this.idJson,
      required this.userId,
      required this.title,
      required this.body});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_json': idJson,
      'user_id': userId,
      'title': title,
      'body': body
    };
  }

  @override
  String toString() {
    return 'JsonData{di: $id, id_json: $idJson, user_id: $userId, title: $title, body: $body}';
  }
}