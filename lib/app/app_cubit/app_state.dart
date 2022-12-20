part of 'app_cubit.dart';

enum UserStatus {
  authenticated,
  unAuthenticated,
}

class AppState extends Equatable {
  const AppState({
    this.userStatus = UserStatus.unAuthenticated,
    this.user,
  });

  final UserStatus userStatus;
  final User? user;

  AppState copyWith({User? user, UserStatus? userStatus}) => AppState(
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
      );

  @override
  List<Object?> get props => [userStatus, user];
}
