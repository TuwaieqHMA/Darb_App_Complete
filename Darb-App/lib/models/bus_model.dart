class Bus {
  Bus({
    this.id,
    required this.seatsNumber,
    required this.busPlate,
    required this.dateIssue,
    required this.dateExpire,
    required this.driverId,
    required this.supervisorId,
  });
  
  final int? id;
  late final int seatsNumber;
  late final String busPlate;
  late final DateTime dateIssue;
  late final DateTime dateExpire;
  late final String driverId;
  late final String supervisorId;
  
  Bus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        seatsNumber = json['seats_number'],
        busPlate = json['bus_plate'],
        dateIssue = DateTime.parse(json['date_issue']),
        dateExpire = DateTime.parse(json['date_expire']),
        driverId = json['driver_id'],
        supervisorId = json['supervisor_id'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['id'] = id; // No need to send the id since it's auto-generated 
    _data['seats_number'] = seatsNumber;
    _data['bus_plate'] = busPlate;
    _data['date_issue'] = dateIssue.toIso8601String();
    _data['date_expire'] = dateExpire.toIso8601String();
    _data['driver_id'] = driverId;
    _data['supervisor_id'] = supervisorId;
    return _data;
  }
}


// {
//      "id": 5,
//      "seats_number": 40,
//      "bus_plate": "1439-HMA",
//      "date_issue": "2024-04-12T00:00:00.000",
//      "date_expire": "2024-04-12T00:00:00.000",
//      "driver_id": "82672jidccen",
//      "supervisor_id": "jencijn3298e00"
// }