import 'package:equatable/equatable.dart';

/// To store data from the connected wallet
class User extends Equatable {
  final String? id;

  const User({this.id});

  get isNotEmpty => id != null && id!.isNotEmpty;

  User copyWith({String? id}) {
    return User(id: id ?? this.id);
  }

  @override
  List<Object?> get props => [id];
}
