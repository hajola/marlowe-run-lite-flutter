part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppForgetWalletRequested extends AppEvent {
  const AppForgetWalletRequested();
}

class AppWalletChanged extends AppEvent {
  const AppWalletChanged(this.user);

  final User user;
}
