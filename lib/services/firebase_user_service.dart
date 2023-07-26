import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facechat/models/user/user.dart';
import 'package:facechat/services/firebase_data_service.dart';
import 'package:facechat/services/firebase_sign_up_information_service.dart';

class FirebaseUserService {
  static final FirebaseUserService _instance = FirebaseUserService();
  factory FirebaseUserService() => _instance;

  static const String collection = 'user';

  static Future<bool> register({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> userSignUpInformation,
  }) async {
    try {
      String? userId = await FirebaseDataService.getId(name: collection);
      if (userId == null) return false;
      DateTime signUpDate = DateTime.now();
      Map<String,dynamic> user = {
        'id':userId,
        ...userData,
        'signUpDate':signUpDate.toString(),
      };

      Map<String,dynamic> signUpInformation = {
        'userId':userId,
        ...userSignUpInformation,
      };

      await FirebaseSignUpInformationService.setSignUpInformation(userId: userId, signUpInformation: signUpInformation);

      await FirebaseFirestore.instance.collection(collection).doc(userId).set(user);
      return true;
    } catch (e) {
      log('FirebaseUserService - register Failed : $e');
      return false;
    }
  }

  static Future<User?> getUser({required String userId})async{
    DocumentSnapshot user = await FirebaseFirestore.instance.collection(collection).doc(userId).get();
    if(user.exists){
      Map<String,dynamic> userData = user.data() as Map<String,dynamic>;
      return User.fromJson(userData);
    }
    return null;
  }

}
