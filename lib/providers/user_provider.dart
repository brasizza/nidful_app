import 'package:flutter/material.dart';
import 'package:nidful/models/user.dart';
import 'package:nidful/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
