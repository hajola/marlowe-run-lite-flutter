import 'package:flutter/material.dart';
import 'package:marlowe_run/home.dart';
import 'package:marlowe_run/marlowe-cubit/marlowe_cubit.dart';
import 'package:marlowe_run/marlowe_observer.dart';
import 'package:marlowe_run/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marlowe_run/wallet-cubit/wallet_cubit.dart';

void main() {
  Bloc.observer = const MarloweObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(),
        ),
        BlocProvider<MarloweCubit>(
          create: (context) => MarloweCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Marlowe Run',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff511CF7),
              primary: const Color(0xff511CF7)),
          useMaterial3: true,
        ),
        home: const MainPage(title: 'Marlowe Run'),
      ),
    );
  }
}

class MarloweDestination {
  const MarloweDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  final List<MarloweDestination> destinations = <MarloweDestination>[
    const MarloweDestination('Home', Icon(Icons.home), Icon(Icons.home)),
    const MarloweDestination(
        'Settings', Icon(Icons.settings), Icon(Icons.settings)),
  ];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (screenIndex) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $screenIndex');
    }

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: page,
      ),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (value) => setState(() {
          screenIndex = value;
        }),
        destinations: destinations.map(
          (MarloweDestination destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }
}
