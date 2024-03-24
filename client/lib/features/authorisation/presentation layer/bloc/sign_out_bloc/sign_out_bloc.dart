import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/sign_out.dart';

part 'sign_out_event.dart';
part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutUseCase signOut;

  SignOutBloc({required this.signOut}) : super(SignOutInitial()) {
    on<SignOutEvent>((event, emit) {});
    on<SignOutMyAccountEventPressed>(_signOut);
  }

  void _signOut(
      SignOutMyAccountEventPressed event, Emitter<SignOutState> emit) async {
    emit(SignOutLoading());
    final failureOrUser = await signOut();
    failureOrUser.fold(
      (failure) => emit(SignOutError(message: mapFailureToMessage(failure))),
      (user) => emit(SignOutSuccess()),
    );
  }
}
