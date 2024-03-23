part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInWithEmailAndPassword extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
