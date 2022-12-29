part of 'app_cubit.dart';

enum UserStatus {
  authenticated,
  unAuthenticated,
}

class AppState extends Equatable {
  const AppState({
    this.userStatus = UserStatus.unAuthenticated,
    this.user,
    this.connectivityResult = ConnectivityResult.none,
  });

  final ConnectivityResult connectivityResult;
  final UserStatus userStatus;
  final User? user;

  AppState copyWith({
    User? user,
    UserStatus? userStatus,
    ConnectivityResult? connectivityResult,
  }) =>
      AppState(
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
        connectivityResult: connectivityResult ?? this.connectivityResult,
      );

  @override
  List<Object?> get props => [userStatus, user, connectivityResult];
}
