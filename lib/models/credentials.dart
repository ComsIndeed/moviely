// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Credentials {
  final String apiKey;
  final String readAccessToken;

  Credentials({required this.apiKey, required this.readAccessToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apiKey': apiKey,
      'readAccessToken': readAccessToken,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      apiKey: map['apiKey'] as String,
      readAccessToken: map['readAccessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source) as Map<String, dynamic>);
}
