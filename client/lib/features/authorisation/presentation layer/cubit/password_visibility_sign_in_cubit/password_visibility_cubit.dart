// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState = PasswordVisibilityState(isVisible: isVisible);
    emit(updatedState);
  }
}
