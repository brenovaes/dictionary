import 'dart:convert';

class Payload {
  String id;
  String username;
  int iat;
  int exp;

  Payload({
    required this.id,
    required this.username,
    required this.iat,
    required this.exp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'iat': iat,
      'exp': exp,
    };
  }

  factory Payload.fromMap(Map<String, dynamic> map) {
    return Payload(
      id: map['id'] as String,
      username: map['username'] as String,
      iat: map['iat'] as int,
      exp: map['exp'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payload.fromJson(String source) =>
      Payload.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Payload(id: $id, username: $username, iat: $iat, exp: $exp)';
  }
}
