part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletConnected extends WalletState {}

class WalletDisconnected extends WalletState {}
