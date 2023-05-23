import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marlowe_run/runtime_repository.dart';
import 'package:meta/meta.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit(this._runtimeRepository) : super(UploadState());

  RuntimeRepository _runtimeRepository;

  createContract({required String scJSON, required String address}) async {
    emit(UploadState(status: UploadStatus.loading));
    try {
      String? contractID = await _runtimeRepository.createContract(
          scJSON: scJSON, address: address);
      emit(UploadState(status: UploadStatus.success, contractID: contractID));
    } catch (e) {
      emit(UploadState(status: UploadStatus.error));
    }
  }
}
