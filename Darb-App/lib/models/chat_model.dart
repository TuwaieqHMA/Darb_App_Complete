

class Chat {
  Chat(  
    {this.id,
    this.createdAt,
    required this.driverId,
    required this.studentId,}
  );
  
  final int? id;
  final DateTime? createdAt;
  late final String driverId;
  late final String studentId;
  
  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        driverId = json['driver_id'],
        studentId = json['student_id'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['id'] = id; // No Need to send the id, since it's auto-generated
    // _data['created_at'] = createdAt; // no need to send when it's created since it's auto-generated
    _data['driver_id'] = driverId;
    _data['student_id'] = studentId;
    return _data;
  }
}

// {
//      "id": 14,
//      "created_at": "2024-04-12T00:00:00.000",
//      "driver_id": "dhbouhb8990",
//      "student_id": "jdbibwokdwo98668ed"
// }