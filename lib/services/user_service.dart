import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facechat/models/user/user.dart';
import 'package:facechat/services/sign_up_information_service.dart';

import 'data_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  static const String collection = 'user';

  static Future<bool> register({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> userSignUpInformation,
  }) async {
    try {
      String? userId = await DataService.getId(name: collection);
      if (userId == null) return false;
      DateTime signUpDate = DateTime.now();
      Map<String, dynamic> user = {
        'id': userId,
        ...userData,
        'signUpDate': signUpDate.toString(),
      };

      Map<String, dynamic> signUpInformation = {
        'userId': userId,
        ...userSignUpInformation,
      };

      await SignUpInformationService.setSignUpInformation(
          userId: userId, signUpInformation: signUpInformation);

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(userId)
          .set(user);
      return true;
    } catch (e) {
      log('FirebaseUserService - register Failed : $e');
      return false;
    }
  }

  static Future<String?> get({required String fieldName,required String userId})async{
    try{
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .doc(userId)
          .get();
      if(userSnapshot.exists){
        return userSnapshot.get(fieldName);
      }
      return null;
    }catch(e){
      log('FirebaseUserService - get Failed : $e');
      return null;
    }
  }

  static Future<User?> getUser({required String userId}) async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection(collection)
        .doc(userId)
        .get();
    if (user.exists) {
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      return User.fromJson(userData);
    }
    return null;
  }

  static Future<List<User>> getAroundUser(String userId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('id', isNotEqualTo: userId)
        .get();
    return snapshot.docs
        .map((document) =>
            User.fromJson(document.data() as Map<String, dynamic>))
        .toList();
  }
}
