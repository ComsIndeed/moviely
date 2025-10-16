import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:moviely/models/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreRepository {
  FirestoreRepository(this._prefs);
  final SharedPreferences _prefs;

  static const credentialsKey = "credentials";

  Future<Credentials?> get credentials async {
    try {
      final credentialsJson = _prefs.getString(credentialsKey);
      if (credentialsJson != null) {
        return Credentials.fromJson(credentialsJson);
      }

      final document = await FirebaseFirestore.instance
          .collection('moviely')
          .doc('creds')
          .get();
      final data = document.data() as Map<String, dynamic>;
      final apiKey = data['apiKey'] as String;
      final readAccessToken = data['readAccessToken'] as String;
      final credentials = Credentials(
        apiKey: apiKey,
        readAccessToken: readAccessToken,
      );
      _prefs.setString(credentialsKey, credentials.toJson());
      return credentials;
    } catch (e) {
      debugPrint("Error getting credentials: $e");
    }
    return null;
  }
}
