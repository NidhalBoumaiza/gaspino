import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'reset_password_visibility_state.dart';

class ResetPasswordVisibilityCubit extends Cubit<ResetPasswordVisibilityState> {
  ResetPasswordVisibilityCubit()
      : super(ResetPasswordVisibilityState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState = ResetPasswordVisibilityState(isVisible: isVisible);
    emit(updatedState);
  }
}
