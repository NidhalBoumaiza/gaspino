// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings.dart';
import '../../../domain layer/entities/user.dart';
import '../../../domain layer/usecases/sign_up.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});

    on<SignUpButtonPressed>(_signUpButtonPressed);
  }

  _signUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    final failureOrUnit = await signUpUseCase(event.user);

    failureOrUnit.fold(
        (failure) => emit(SignUpError(message: mapFailureToMessage(failure))),
        (unit) => emit(SignUpSuccess(message: SignUpSuccessMessage)));
  }
}
