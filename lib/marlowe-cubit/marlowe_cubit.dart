import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:file_picker/file_picker.dart';

part 'marlowe_state.dart';

class MarloweCubit extends Cubit<MarloweState> {
  MarloweCubit() : super(MarloweState());

  void loadscJSON(String scJSON, String fileName) {
    emit(MarloweState(
        scJSON: scJSON, status: MarloweStatus.loaded, fileName: fileName));
  }

  void storeWalletAddress(String address) {
    emit(
      MarloweState(address: address),
    );
  }

  void storeSkeyFile(PlatformFile skeyFile) {
    emit(
      MarloweState(skeyFile: skeyFile),
    );
  }
}
