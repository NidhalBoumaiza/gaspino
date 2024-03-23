part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  User user;

  SignInSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class SignInError extends SignInState {
  final String message;

  SignInError({required this.message});

  @override
  List<Object> get props => [message];
}
