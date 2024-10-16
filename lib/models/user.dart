import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String? usrEmail;
  final String? usrName;
  final String usrPassword;

  Users({
    this.usrId,
    this.usrEmail,
    this.usrName,
    required this.usrPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    usrEmail: json["email"],
    usrName: json["usrName"],
    usrPassword: json["usrPassword"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "usrEmail": usrEmail,
    "usrName": usrName,
    "usrPassword": usrPassword,
  };
}