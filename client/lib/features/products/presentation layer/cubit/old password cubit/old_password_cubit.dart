import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'old_password_state.dart';

class OldPasswordCubit extends Cubit<OldPasswordState> {
  OldPasswordCubit() : super(OldPasswordState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState = OldPasswordState(isVisible: isVisible);
    emit(updatedState);
  }
}
