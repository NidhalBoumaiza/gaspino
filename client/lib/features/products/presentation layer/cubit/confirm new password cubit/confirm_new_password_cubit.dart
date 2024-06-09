import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'confirm_new_password_state.dart';

class ConfirmNewPasswordCubit extends Cubit<ConfirmNewPasswordState> {
  ConfirmNewPasswordCubit() : super(ConfirmNewPasswordState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState = ConfirmNewPasswordState(isVisible: isVisible);
    emit(updatedState);
  }
}
