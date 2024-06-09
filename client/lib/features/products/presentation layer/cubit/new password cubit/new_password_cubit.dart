import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit() : super(NewPasswordState(isVisible: false));

  void changeVisibility() {
    final isVisible = !state.isVisible;
    final updatedState = NewPasswordState(isVisible: isVisible);
    emit(updatedState);
  }
}
