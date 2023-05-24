import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marlowe_run/runtime_repository.dart';
import 'package:meta/meta.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit(this._runtimeRepository) : super(UploadState());

  RuntimeRepository _runtimeRepository;

  createContract({required String scJSON, required String address}) async {
    emit(state.copyWith(status: UploadStatus.loading, message: "Creating"));
    try {
      String? contractURL = await _runtimeRepository.createContract(
        scJSON: scJSON,
        address: address,
        updateLoadingMessage: updateLoadingMessage,
      );
      emit(state.copyWith(
          status: UploadStatus.success, contractID: contractURL));
    } catch (e) {
      emit(state.copyWith(status: UploadStatus.error));
    }
  }

  getContractDetails() async {
    emit(state.copyWith(
        status: UploadStatus.loading, message: "Getting details"));
    try {
      if (state.contractURL == null) throw Exception("Contract ID is null");
      dynamic resource =
          await _runtimeRepository.getContractDetails(state.contractURL);
      emit(state.copyWith(status: UploadStatus.success, resource: resource));
    } catch (e) {
      emit(state.copyWith(status: UploadStatus.error));
    }
  }

  saveContractId({required String contractId}) {
    if (contractId.isNotEmpty)
      emit(state.copyWith(
          status: UploadStatus.success, contractID: "contracts/$contractId"));
  }

  updateLoadingMessage({required String message}) {
    if (message.isNotEmpty)
      emit(state.copyWith(status: UploadStatus.loading, message: message));
  }
}
