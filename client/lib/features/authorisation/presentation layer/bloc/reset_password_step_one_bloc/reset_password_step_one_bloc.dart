import 'package:bloc/bloc.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';

import '../../../domain layer/usecases/reset_password_step_one.dart';

part 'reset_password_step_one_event.dart';
part 'reset_password_step_one_state.dart';

class ResetPasswordStepOneBloc
    extends Bloc<ResetPasswordStepOneEvent, ResetPasswordStepOneState> {
  ResetPasswordStepOneUseCase forgetPasswordStepOneUseCase;

  ResetPasswordStepOneBloc({required this.forgetPasswordStepOneUseCase})
      : super(ResetPasswordStepOneInitial()) {
    on<ResetPasswordStepOneEvent>((event, emit) {});

    on<ResetPasswordStepOneCodeCheck>(_resetPasswordStepOneCodeCheck);
  }

  void _resetPasswordStepOneCodeCheck(ResetPasswordStepOneCodeCheck event,
      Emitter<ResetPasswordStepOneState> emit) async {
    emit(ResetPasswordStepOneLoading());
    final failureOrUnit =
        await forgetPasswordStepOneUseCase(event.passwordResetCode);
    failureOrUnit.fold(
      (failure) => emit(
          ResetPasswordStepOneError(message: mapFailureToMessage(failure))),
      (_) => emit(ResetPasswordStepOneSuccess()),
    );
  }
}
