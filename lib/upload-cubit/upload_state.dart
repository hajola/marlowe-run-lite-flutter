part of 'upload_cubit.dart';

enum UploadStatus { initial, loading, error, success }

class UploadState extends Equatable {
  const UploadState({
    this.status = UploadStatus.initial,
    this.contractID,
  });

  final String? contractID;

  final UploadStatus status;

  @override
  List<Object?> get props => [status, contractID];

  UploadState copyWith({
    UploadStatus? status,
    String? contractID,
  }) {
    return UploadState(
        status: status ?? this.status,
        contractID: contractID ?? this.contractID);
  }
}
