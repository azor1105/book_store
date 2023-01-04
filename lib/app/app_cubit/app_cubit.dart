import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/models/user/user_model.dart';
import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/pick_img.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState()) {
    checkInternet();
    userAuthStateChanges();
  }

  final AuthRepository _authRepository;
  late StreamSubscription<User?> _streamSubscriptionAuthState;
  late StreamSubscription<UserModel> _streamSubscriptionUser;
  late StreamSubscription<ConnectivityResult> _streamSubscriptionConnectivity;

  final Connectivity _connectivity = Connectivity();

  void checkInternet() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) {
      emit(state.copyWith(connectivityResult: event));
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    emit(state.copyWith(connectivityResult: result));
  }

  void userAuthStateChanges() {
    bool isOpen = true;
    _streamSubscriptionAuthState = _authRepository.userInfoChanges.listen(
      (firebaseUser) {
        if (isOpen) {
          if (firebaseUser?.uid != null) {
            isOpen = false;
            fetchUser(firebaseUser!.uid);
          }
        }
        emit(
          state.copyWith(
            userStatus: firebaseUser?.uid == null
                ? UserStatus.unAuthenticated
                : UserStatus.authenticated,
          ),
        );
      },
    );
  }

  void fetchUser(String uid) {
    _streamSubscriptionUser = _authRepository.fetchUser(uid: uid).listen(
      (user) {
        emit(
          state.copyWith(user: user),
        );
      },
    );
  }

  Future<void> uploadImg({bool fromCamera = true}) async {
    late XFile? file;
    if (fromCamera) {
      file = await getFromCamera();
    } else {
      file = await getFromGallery();
    }
    if (file != null) {
      emit(state.copyWith(status: Status.loading));
      await _authRepository.uploadImage(userModel: state.user!, file: file);
      emit(state.copyWith(status: Status.success));
    } else {
      MyUtils.getMyToast(message: 'Image is not picked');
    }
  }

  @override
  Future<void> close() {
    _streamSubscriptionAuthState.cancel();
    _streamSubscriptionConnectivity.cancel();
    _streamSubscriptionUser.cancel();
    return super.close();
  }
}
