import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState());

  final AuthRepository _authRepository;
  late StreamSubscription<User?> _streamSubscription;

  void userInfoChanges() {
    _streamSubscription = _authRepository.userInfoChanges.listen(
      (user) {
        emit(
          state.copyWith(
            user: user,
            userStatus: user?.uid == null
                ? UserStatus.unAuthenticated
                : UserStatus.authenticated,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
