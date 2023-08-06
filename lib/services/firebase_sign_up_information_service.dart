import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSignUpInformationService {
  static final FirebaseSignUpInformationService _instance =
      FirebaseSignUpInformationService();
  factory FirebaseSignUpInformationService() => _instance;

  static const String collection = 'signUpInformation';

  static Future<bool> setSignUpInformation({
    required String userId,
    required Map<String, dynamic> signUpInformation,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(userId)
          .set(signUpInformation);
      return true;
    } catch (e) {
      log('FirebaseSignUpInformationService - setSignUpInformationService Failed : $e');
      return false;
    }
  }

  static Future<String?> findSocialSignInInformation({
    required String social,
    required String value,
  }) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where(social, isEqualTo: value)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('userId');
      }
      return null;
    } catch (e) {
      log('FirebaseSignUpInformationService - findSocialSignInInformation Failed : $e');
      return null;
    }
  }

  static Future<String?> findSignUpInformation({
    required String email,
    required String password,
  }) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('userId');
      }
      return null;
    } catch (e) {
      log('FirebaseSignUpInformationService - findSignUpInformation Failed : $e');
      return null;
    }
  }
}
