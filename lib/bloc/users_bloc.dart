import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_event.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_repository.dart';
import 'package:flutter_bloc_firestore_sample_app/bloc/users_state.dart';
import 'package:flutter_bloc_firestore_sample_app/model/user.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;
  StreamSubscription? usersSubscription;

  UsersBloc({required this.usersRepository}) : super(UsersUnintialized()) {
    on<LoadUsers>(_mapLoadUsers);
    on<UpdateUsers>(_mapUpdateUsersToState);
  }

  Future<void> _mapLoadUsers(LoadUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());

    try {
      Stream<List<User>> usersStream = usersRepository.queryUsers();

      usersSubscription?.cancel();
      usersSubscription =
          usersStream.listen((users) => add(UpdateUsers(users: users)));
    } on Exception catch (e) {
      emit(UsersLoadFailed(e.toString()));
    }
  }

  void _mapUpdateUsersToState(
      UpdateUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoaded(users: event.users));
  }
}
