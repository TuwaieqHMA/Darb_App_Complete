import 'package:flutter/material.dart';
class Trip {
  Trip({
    this.id,
    required this.district,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.driverId,
    required this.isToSchool,
    required this.supervisorId,
  });

  final int? id;
  late final String district;
  late final DateTime date;
  late final TimeOfDay timeFrom;
  late final TimeOfDay timeTo;
  late final String driverId;
  late final bool isToSchool;
  late final String supervisorId;

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        district = json['district'],
        date = DateTime.parse(json['date']),
        timeFrom = _parseTimeOfDay(json['time_from']),
        timeTo = _parseTimeOfDay(json['time_to']),
        driverId = json['driver_id'],
        isToSchool = json['isToSchool'],
        supervisorId = json['supervisor_id'];

  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // No Need to send the id, since its auto generated
      'district': district,
      'date': date.toIso8601String(),
      'time_from': '${timeFrom.hour}:${timeFrom.minute}',
      'time_to': '${timeTo.hour}:${timeTo.minute}',
      'driver_id': driverId,
      'isToSchool': isToSchool,
      'supervisor_id': supervisorId,
    };
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}


// {
//   "id": 1,
//   "district": "Sample District",
//   "date": "2024-04-12T00:00:00.000",
//   "time_from": "8:30",
//   "time_to": "10:0",
//   "driver_id": "driver123",
//   "isToSchool": true
// }
