// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'reset_confirm_password_visibility_state.dart';

class ResetConfirmPasswordVisibilityCubit
    extends Cubit<ResetConfirmPasswordVisibilityState> {
  ResetConfirmPasswordVisibilityCubit()
      : super(ResetConfirmPasswordVisibilityState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState =
        ResetConfirmPasswordVisibilityState(isVisible: isVisible);
    emit(updatedState);
  }
}
