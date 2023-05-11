import 'dart:convert';

class AuthModel {
  final String accessToken;

  AuthModel({required this.accessToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: (map['access_token'] ?? '') as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AuthModel.fromJson(String source) {
    return AuthModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
  }
}
