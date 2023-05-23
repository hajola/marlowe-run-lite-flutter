part of 'marlowe_cubit.dart';

enum MarloweStatus { unloaded, loaded }

class MarloweState extends Equatable {
  const MarloweState({
    this.status = MarloweStatus.unloaded,
    this.scJSON,
    this.fileName,
  });

  final MarloweStatus status;
  final String? scJSON;
  final String? fileName;

  @override
  List<Object?> get props => [status, scJSON, fileName];

  MarloweState copyWith({
    MarloweStatus? status,
    String? scJSON,
    String? fileName,
  }) {
    return MarloweState(
      status: status ?? this.status,
      scJSON: scJSON ?? this.scJSON,
      fileName: fileName ?? this.fileName,
    );
  }
}
