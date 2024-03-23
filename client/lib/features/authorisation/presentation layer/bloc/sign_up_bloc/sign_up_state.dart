part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {}

final class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpSuccess extends SignUpState {
  final String message;

  SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class SignUpError extends SignUpState {
  final String message;

  SignUpError({required this.message});

  @override
  List<Object?> get props => [message];
}
