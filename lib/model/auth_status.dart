import 'package:flutter_bloc_firestore_sample_app/model/fbuser.dart';

class AuthStatus {
  bool initialized = false;
  FBUser? fbUser;

  init({FBUser? fbUser}) {
    this.fbUser = fbUser;
    initialized = true;
  }
}
