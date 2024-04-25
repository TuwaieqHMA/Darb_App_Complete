class Driver {
  Driver({
    required this.id,
    this.noTrips,
    this.hasBus,
    required this.supervisorId,
  });
  late final String id;
  int? noTrips;
  bool? hasBus;
  late final String supervisorId;
  
  Driver.fromJson(Map<String, dynamic> json){
    id = json['id'];
    noTrips = json['no_trips'];
    hasBus = json['has_bus'];
    supervisorId = json['supervisor_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    // _data['no_trips'] = noTrips; // automatically set to 0
    // _data['has_bus'] = hasBus; // automatically set to false 
    _data['supervisor_id'] = supervisorId; 
    return _data;
  }
}

// {
//      "id": "dasjd9n29973927",
//      "no_trips": 0,
//      "has_bus": false,
//      "supervisor_id": "wjbijwbe9785762"
// }