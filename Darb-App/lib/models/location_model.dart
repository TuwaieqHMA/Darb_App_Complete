class Location {
  Location({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });
  late final String userId;
  late final double latitude;
  late final double longitude;
  
  Location.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}

// {
//      "user_id": "ijbc8ebuh990",
//      "latitude": 23.987067,
//      "longitude": 48.8634526
// }