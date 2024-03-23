part of 'reset_password_step_one_bloc.dart';

abstract class ResetPasswordStepOneState extends Equatable {}

final class ResetPasswordStepOneInitial extends ResetPasswordStepOneState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordStepOneLoading extends ResetPasswordStepOneState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordStepOneSuccess extends ResetPasswordStepOneState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordStepOneError extends ResetPasswordStepOneState {
  final String message;

  ResetPasswordStepOneError({required this.message});

  @override
  List<Object?> get props => [message];
}
