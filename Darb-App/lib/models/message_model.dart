class Message {
  Message({
    this.id,
    required this.createdAt,
    required this.message,
    required this.userId,
    required this.chatId,
    required this.isMine,
  });
  
  late final int? id;
  DateTime createdAt;
  late final String message;
  late final String userId;
  late final int chatId;
  bool isMine;
  
  Message.fromJson({required Map<String, dynamic> json,
  required String myUserID,})
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        message = json['message'],
        userId = json['user_id'],
        chatId = json['chat_id'],
        isMine = myUserID == json['user_id'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // _data['id'] = id; // No Need to send the id, since it's auto-generated
    // _data['created_at'] = createdAt.toIso8601String(); // No need to send the creation time since it's auto generated
    data['message'] = message;
    data['user_id'] = userId;
    data['chat_id'] = chatId;
    return data;
  }
}


// {
//      "id": 13,
//      "created_at": "2024-04-12T00:00:00.000",
//      "message": "hello, can you please come down?",
//      "user_id": "bfihebwieh873y872",
//      "chat_id": 19
// }