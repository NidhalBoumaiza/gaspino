import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'reset_password_visibility_state.dart';

class ResetPasswordVisibilityCubit extends Cubit<ResetPasswordVisibilityState> {
  ResetPasswordVisibilityCubit()
      : super(ResetPasswordVisibilityState(isVisible: false));

  void changeVisibility() {
    print(state.isVisible);
    final isVisible = !state.isVisible;
    print('isVisible: $isVisible');
    final updatedState = ResetPasswordVisibilityState(isVisible: isVisible);
    emit(updatedState);
  }
}
