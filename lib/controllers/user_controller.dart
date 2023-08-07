import 'dart:developer';
import 'package:facechat/services/user_service.dart';
import 'package:flutter/material.dart';
import '../models/user/user.dart';

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
      User? newUser = await UserService.getUser(userId: user!.id);
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
