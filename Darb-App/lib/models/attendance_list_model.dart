// Note that this model will probably be used when adding to the table, but not when reading from it.

class AttendanceList {
  AttendanceList({
    required this.tripId,
    required this.studentId,
    this.status,
  });
  late final int tripId;
  late final String studentId;
  String? status;
  
  AttendanceList.fromJson(Map<String, dynamic> json){
    tripId = json['trip_id'];
    studentId = json['student_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trip_id'] = tripId;
    _data['student_id'] = studentId;
    // _data['status'] = status; // Not neccssary when sending since it'll have a default value within the database 
    return _data;
  }
}