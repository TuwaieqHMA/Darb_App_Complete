class Student {
  Student({
    this.id,
    this.latitude,
    this.longitude,
    this.supervisorId,
  });
  late final String? id;
  late final double? latitude;
  late final double? longitude;
  late final String? supervisorId;
  
  Student.fromJson(Map<String, dynamic> json){
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    supervisorId = json['supervisor_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['supervisor_id'] = supervisorId; //Can be nulled since the user may start without being signed to a supervisor
    return _data;
  }
}

// {
//      "id": "dijiejn8897",
//      "latitude": 23.9873688,
//      "longitude": 87.835217,
//      "supervisor_id": "hebivsw97372"
// }