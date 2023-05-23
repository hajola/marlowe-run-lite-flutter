import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marlowe_run/authentication_repository.dart';

import '../models/user.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const AppState.walletDisconnexted(),
        ) {
    on<AppWalletChanged>(_onWalletChanged);
    on<AppForgetWalletRequested>(_onForgetWalletRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onWalletChanged(AppWalletChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.walletConnected(event.user)
          : const AppState.walletDisconnexted(),
    );
  }

  void _onForgetWalletRequested(
      AppForgetWalletRequested event, Emitter<AppState> emit) {
    // TODO
    // probably just navigate back and clear memory or something
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
