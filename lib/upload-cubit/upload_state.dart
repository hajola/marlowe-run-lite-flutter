part of 'upload_cubit.dart';

enum UploadStatus { initial, loading, error, success }

class UploadState extends Equatable {
  const UploadState({
    this.status = UploadStatus.initial,
    this.contractURL,
    this.message,
    this.resource,
  });

  final String? contractURL;
  final String? message;
  // contract details - redo/rename and fix later
  final dynamic? resource;
  final UploadStatus status;

  @override
  List<Object?> get props => [status, contractURL, message, resource];

  UploadState copyWith(
      {UploadStatus? status,
      String? contractID,
      String? message,
      dynamic? resource}) {
    return UploadState(
      status: status ?? this.status,
      contractURL: contractID ?? this.contractURL,
      message: message ?? this.message,
      resource: resource ?? this.resource,
    );
  }
}
