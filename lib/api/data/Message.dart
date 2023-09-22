class Message {

  String message;

  Message({required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Message(message: json['message'] as String);
    } else {
      return Message(message: 'Unknown Error');
    }
  }
}