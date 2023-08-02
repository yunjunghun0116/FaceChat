import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/user/user.dart';
import '../services/firebase_user_service.dart';

class UserController extends ChangeNotifier {
  User? user;

  Future<void> setUser(User newUser) async {
    try {
      user = newUser;
      notifyListeners();
    } catch (e) {
      log('UserController - setUser Failed : $e');
    }
  }

  Future<void> refreshUser() async {
    try {
      if (user == null) return;
      User? newUser = await FirebaseUserService.getUser(userId: user!.id);
      if (newUser == null) return;
      user = newUser;
      notifyListeners();
    } catch (e) {
      log('UserController - refreshUser Failed : $e');
    }
  }

  Future<void> logout() async {
    user = null;
    notifyListeners();
  }
}
