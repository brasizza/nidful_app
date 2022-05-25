import 'package:get/get.dart';
import 'package:nidful/models/user.dart';
import 'package:nidful/resources/auth_methods.dart';

class UserController extends GetxController {
  // get userDetails
  Future<User?> refreshUser() async {
    User currentUser = await AuthMethod().getUserDetails();
    return currentUser;
  }
}
