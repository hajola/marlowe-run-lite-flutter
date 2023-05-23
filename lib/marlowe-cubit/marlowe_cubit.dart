import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'marlowe_state.dart';

class MarloweCubit extends Cubit<MarloweState> {
  MarloweCubit() : super(MarloweState());

  void loadscJSON(String scJSON, String fileName) {
    emit(MarloweState(
        scJSON: scJSON, status: MarloweStatus.loaded, fileName: fileName));
  }
}
