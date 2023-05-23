part of 'marlowe_cubit.dart';

enum MarloweStatus { unloaded, loaded }

class MarloweState extends Equatable {
  const MarloweState({
    this.status = MarloweStatus.unloaded,
    this.scJSON,
    this.fileName,
    this.address,
    this.skeyFile,
  });

  final MarloweStatus status;
  final String? scJSON;
  final String? fileName;
  final String? address;
  final PlatformFile? skeyFile;

  @override
  List<Object?> get props => [status, scJSON, fileName, address, skeyFile];

  MarloweState copyWith({
    MarloweStatus? status,
    String? scJSON,
    String? fileName,
    String? address,
    PlatformFile? skeyFile,
  }) {
    return MarloweState(
      status: status ?? this.status,
      scJSON: scJSON ?? this.scJSON,
      fileName: fileName ?? this.fileName,
      address: address ?? this.address,
      skeyFile: skeyFile ?? this.skeyFile,
    );
  }
}
