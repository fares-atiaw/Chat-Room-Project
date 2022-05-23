class M_User {
  static const String CollectionName = 'M_User';

  String? id;
  String? fName;
  String? lName;
  String? username;
  String? email;

  M_User({
    this.id,
    this.fName,
    this.lName,
    this.username,
    this.email,
  });

  M_User.fromJson(dynamic json) {
    id = json['id'] as String;
    fName = json['f_name'] as String;
    lName = json['l_name'] as String;
    username = json['username'] as String;
    email = json['email'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['f_name'] = fName;
    map['l_name'] = lName;
    map['username'] = username;
    map['email'] = email;
    return map;
  }
}
