import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bnv_state.dart';

class BnvCubit extends Cubit<BnvState> {
  BnvCubit() : super(BnvState(currentIndex: 0));

  void changeIndex(int index) {
    final updatedState = BnvState(currentIndex: index);
    emit(updatedState);
  }
}
