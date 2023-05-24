import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marlowe_run/home.dart';
import 'package:marlowe_run/marlowe-cubit/marlowe_cubit.dart';
import 'package:marlowe_run/marlowe_observer.dart';
import 'package:marlowe_run/routes.dart';
import 'package:marlowe_run/runtime_repository.dart';
import 'package:marlowe_run/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marlowe_run/upload-cubit/upload_cubit.dart';
import 'package:marlowe_run/wallet-cubit/wallet_cubit.dart';

import 'authentication_repository.dart';
import 'bloc/app_bloc.dart';

void main() {
  Bloc.observer = const MarloweObserver();
  final AuthenticationRepository authRepo = AuthenticationRepository();
  final RuntimeRepository runRepo = RuntimeRepository();
  runApp(MyApp(
    authenticationRepository: authRepo,
    runtimeRepository: runRepo,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.authenticationRepository,
      required this.runtimeRepository});

  final AuthenticationRepository authenticationRepository;
  final RuntimeRepository runtimeRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppBloc appbloc;

  @override
  void initState() {
    // TODO: implement initState
    appbloc = AppBloc(
      authenticationRepository: widget.authenticationRepository,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
            value: widget.authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => appbloc,
          ),
          BlocProvider<MarloweCubit>(
            create: (context) => MarloweCubit(),
          ),
          BlocProvider<AppRouter>(
            create: (context) => AppRouter(appbloc),
          ),
          BlocProvider<UploadCubit>(
            create: (context) => UploadCubit(widget.runtimeRepository),
          ),
        ],
        child: Builder(
          builder: (BuildContext context) {
            final GoRouter router = context.read<AppRouter>().router;
            return MaterialApp.router(
              routerConfig: router,
              title: 'Marlowe Run',
              theme: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: const Color(0xff511CF7),
                    background: const Color(0xffF8F8FF)),
                useMaterial3: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
