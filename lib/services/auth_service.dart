import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firestore_sample_app/model/auth_status.dart';
import 'package:flutter_bloc_firestore_sample_app/model/fbuser.dart';
import 'package:flutter_bloc_firestore_sample_app/utils/log.dart';

class AuthService extends ChangeNotifier {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseMessaging _msg = FirebaseMessaging.instance;

  AuthStatus authStatus = AuthStatus();

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<bool> _requestPermission() async {
    NotificationSettings settings = await _msg.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
      });
      return true;
    } else {
      log('User declined or has not accepted permission');
      return false;
    }
  }

  AuthService() {
    log('AuthService: initializing.... listen to auth state changes');
    _requestPermission();
    _auth.authStateChanges().listen((User? user) async {
      log('authStateChanges listener triggered:  ${user?.toString()}');
      if (user != null) {
        FBUser? fbUser = FBUser(user.uid);
        log('AuthService: found fbUser');
        authStatus.init(fbUser: fbUser);
      } else {
        log('AuthService: no fbUser');
        authStatus.init();
      }
      log('AuthService: notify listeners...');
      notifyListeners();
    });
  }

  Future<String?> signIn() async {
    try {
      log('signing in anonymoushly...');
      await _auth.signInAnonymously();
      log('signed in');
      return null;
    } on Exception catch (err) {
      log('failed to sign in to Firebase anonymously: ${err.toString()}');
      return err.toString();
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on Exception catch (err) {
      log('failed to signOut: ${err.toString()}');
      return err.toString();
    }
  }
}
