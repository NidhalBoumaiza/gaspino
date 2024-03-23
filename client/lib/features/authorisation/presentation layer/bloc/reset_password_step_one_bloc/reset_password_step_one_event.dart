part of 'reset_password_step_one_bloc.dart';

abstract class ResetPasswordStepOneEvent extends Equatable {}

class ResetPasswordStepOneCodeCheck extends ResetPasswordStepOneEvent {
  final String passwordResetCode;

  ResetPasswordStepOneCodeCheck({required this.passwordResetCode});

  @override
  List<Object?> get props => [passwordResetCode];
}
