import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityState(isVisible: false));

  void changeVisibility() {
    print(state.isVisible);
    final isVisible = !state.isVisible;
    print('isVisible: $isVisible');
    final updatedState = PasswordVisibilityState(isVisible: isVisible);
    emit(updatedState);
  }
}
