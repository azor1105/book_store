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
    this.status = Status.pure,
  });

  final Status status;
  final ConnectivityResult connectivityResult;
  final UserStatus userStatus;
  final User? user;

  AppState copyWith({
    User? user,
    UserStatus? userStatus,
    ConnectivityResult? connectivityResult,
    Status? status,
  }) =>
      AppState(
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
        connectivityResult: connectivityResult ?? this.connectivityResult,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [userStatus, user, connectivityResult, status];
}
