import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_firestore_sample_app/model/user.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UsersEvent {}

class UpdateUsers extends UsersEvent {
  final List<User> users;

  UpdateUsers({required this.users});

  @override
  List<Object?> get props => [users];
}
