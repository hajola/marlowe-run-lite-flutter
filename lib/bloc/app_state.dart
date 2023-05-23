part of 'app_bloc.dart';

enum AppStatus {
  authenticated, // aka wallet connected
  unauthenticated, // aka no wallet connected
}

class AppState extends Equatable {
  const AppState._({required this.status, this.user});

  const AppState.walletConnected(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.walletDisconnexted()
      : this._(status: AppStatus.unauthenticated, user: const User());

  final AppStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
