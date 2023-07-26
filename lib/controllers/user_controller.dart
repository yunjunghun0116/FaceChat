import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/user/user.dart';
import '../services/firebase_user_service.dart';

class UserController extends ChangeNotifier {
  User? user;

  Future<bool> setUser(User newUser) async {
    try {
      user = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      log('UserController - setUser Failed : $e');
      return false;
    }
  }

  Future<bool> refreshUser() async {
    try {
      if (user == null) return false;
      User? newUser = await FirebaseUserService.getUser(userId: user!.id);
      if (newUser == null) return false;
      user = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      log('UserController - refreshUser Failed : $e');
      return false;
    }
  }

  Future<void> logout() async {
    user = null;
    notifyListeners();
  }
}
