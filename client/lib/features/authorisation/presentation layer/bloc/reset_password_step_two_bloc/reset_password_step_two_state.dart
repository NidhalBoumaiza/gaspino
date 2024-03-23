part of 'reset_password_step_two_bloc.dart';

abstract class ResetPasswordStepTwoState extends Equatable {}

final class ResetPasswordStepTwoInitial extends ResetPasswordStepTwoState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordStepTwoLoading extends ResetPasswordStepTwoState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordStepTwoSuccess extends ResetPasswordStepTwoState {
  final String message;

  ResetPasswordStepTwoSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ResetPasswordStepTwoError extends ResetPasswordStepTwoState {
  final String message;

  ResetPasswordStepTwoError({required this.message});

  @override
  List<Object?> get props => [message];
}
