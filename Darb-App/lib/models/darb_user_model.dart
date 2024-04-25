class DarbUser {
  DarbUser({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
  });
  String? id;
  late final String name;
  late final String email;
  late final String phone;
  late final String userType;
  
  DarbUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['user_type'] = userType;
    return _data;
  }
}

// {
//   "name": "John Doe",
//   "email": "johndoe@example.com",
//   "phone": "123456789",
//   "user_type": "regular"
// }