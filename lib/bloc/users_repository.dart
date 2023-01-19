import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firestore_sample_app/model/user.dart';

class UsersRepository {
  static final _db = FirebaseFirestore.instance;

  Stream<List<User>> queryUsers() {
    var usersColRef = _db.collection('users');

    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        usersColRef.snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) => User.fromDoc(doc, true)).toList();
    });
  }
}
