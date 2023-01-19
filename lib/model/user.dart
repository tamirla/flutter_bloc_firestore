import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String docId;
  final String name;
  final String address;
  final String phoneNumber;

  const User(this.docId, this.name, this.address, this.phoneNumber);

  static User fromDoc(DocumentSnapshot<Object?> doc, bool isCurrentUser) {
    var props = doc.data() as Map<String, dynamic>;
    return User(
        doc.id, props['name'], props['address'], props['phoneNumber'] ?? '');
  }

  // static int deliveryPrice(DocumentSnapshot<Object?> doc) {
  //   var props = doc.data() as Map<String, dynamic>;
  //   return props['price'] ?? 0;
  // }

  @override
  List<Object?> get props => [docId, name, address, phoneNumber];
}
