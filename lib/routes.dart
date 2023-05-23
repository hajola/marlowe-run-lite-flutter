import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marlowe_run/screens/contract-details/contract_details_screen.dart';
import 'package:marlowe_run/screens/contract-run/contract_run_screen.dart';
import 'package:marlowe_run/screens/contract-upload/contract_upload_screen.dart';
import 'package:marlowe_run/screens/wallet-select/wallet_select_screen.dart';

import 'bloc/app_bloc.dart';

/// routes
class AppRouter extends Bloc<AppEvent, AppState> {
  /// create routes with authentication bloc
  AppRouter(this.appBloc) : super(appBloc.state);

  /// use authentication bloc for navigation
  late final AppBloc appBloc;

  /// save previous state
  AppState? prevAuthState;

  /// getter
  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    initialLocation: '/wallet',
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) async {
      if (prevAuthState?.status == appBloc.state.status) {
        return null;
      }
      prevAuthState = appBloc.state;
      if (appBloc.state.status == AppStatus.authenticated) {
        debugPrint('Wallet connexted');
        return '/upload';
      } else if (appBloc.state.status == AppStatus.unauthenticated) {
        debugPrint('Wallet disconnected');
        return '/wallet';
      }
      debugPrint('Not returning anything');
      return null;
    },
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          redirect: (_, __) {
            if (appBloc.state.status == AppStatus.authenticated) {
              return '/upload';
            } else {
              return '/wallet';
            }
          }),
      GoRoute(
        path: '/wallet',
        builder: (BuildContext context, GoRouterState state) {
          return ContractUploadScreen();
        },
      ),
      GoRoute(
        path: '/upload',
        builder: (BuildContext context, GoRouterState state) {
          return ContractUploadScreen();
        },
      ),
      GoRoute(
        path: '/details',
        builder: (BuildContext context, GoRouterState state) {
          return const ContractDetailsScreen();
        },
      ),
      GoRoute(
        path: '/run',
        builder: (BuildContext context, GoRouterState state) {
          return const ContractRunScreen();
        },
      ),
    ],
  );
}

/// stream to use go_router refreshListen
class GoRouterRefreshStream extends ChangeNotifier {
  /// notify to all subscribers.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
