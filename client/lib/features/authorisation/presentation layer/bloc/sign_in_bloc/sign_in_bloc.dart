import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/user.dart';
import '../../../domain layer/usecases/sign_in.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signIn;

  SignInBloc({required this.signIn}) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {});

    on<SignInWithEmailAndPassword>(_signInWithEmailAndPassword);
  }

  void _signInWithEmailAndPassword(
      SignInWithEmailAndPassword event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    await Future.delayed(Duration(seconds: 2));
    final failureOrUser = await signIn(event.email, event.password);
    print('failureOrUser: $failureOrUser');
    failureOrUser.fold(
      (failure) => emit(SignInError(message: mapFailureToMessage(failure))),
      (user) => emit(SignInSuccess(user: user)),
    );
  }
}
