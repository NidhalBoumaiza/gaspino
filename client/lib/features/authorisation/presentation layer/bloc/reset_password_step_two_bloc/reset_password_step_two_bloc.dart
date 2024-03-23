import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/reset_password_step_two.dart';

part 'reset_password_step_two_event.dart';
part 'reset_password_step_two_state.dart';

class ResetPasswordStepTwoBloc
    extends Bloc<ResetPasswordStepTwoEvent, ResetPasswordStepTwoState> {
  ResetPasswordStepTwoUseCase resetPasswordStepTwoUseCase;

  ResetPasswordStepTwoBloc({required this.resetPasswordStepTwoUseCase})
      : super(ResetPasswordStepTwoInitial()) {
    on<ResetPasswordStepTwoEvent>((event, emit) {});

    on<ResetPasswordStepTwoReset>(_reserPasswordStepTwoReset);
  }

  void _reserPasswordStepTwoReset(ResetPasswordStepTwoReset event,
      Emitter<ResetPasswordStepTwoState> emit) async {
    emit(ResetPasswordStepTwoLoading());
    final failureOrUnit = await resetPasswordStepTwoUseCase(
      event.passwordResetCode,
      event.password,
      event.passwordConfirm,
    );
    failureOrUnit.fold(
      (failure) => emit(
          ResetPasswordStepTwoError(message: mapFailureToMessage(failure))),
      (_) => emit(ResetPasswordStepTwoSuccess(message: "Password reset")),
    );
  }
}
