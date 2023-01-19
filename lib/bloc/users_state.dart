import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_firestore_sample_app/model/user.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersUnintialized extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  UsersLoaded({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

class UsersLoadFailed extends UsersState {
  final String error;

  UsersLoadFailed(this.error);
}
