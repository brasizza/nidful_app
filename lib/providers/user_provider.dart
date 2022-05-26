import 'package:flutter/material.dart';
import 'package:nidful/models/user.dart';
import 'package:nidful/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = false;
  User? _user;
  final AuthMethod _authMethods = AuthMethod();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
