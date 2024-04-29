// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/forget_password.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordUseCase forgetPassword;

  ForgetPasswordBloc({required this.forgetPassword})
      : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) {});

    on<ForgetPasswordRequest>(_forgetPasswordRequest);
  }

  void _forgetPasswordRequest(
      ForgetPasswordRequest event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordLoading());
    final failureOrUnit = await forgetPassword(event.email);
    failureOrUnit.fold(
      (failure) =>
          emit(ForgetPasswordError(message: mapFailureToMessage(failure))),
      (user) =>
          emit(ForgetPasswordSuccess(message: ForgetPasswordSuccessMessage)),
    );
  }
}
