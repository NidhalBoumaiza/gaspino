part of 'reset_password_step_two_bloc.dart';

abstract class ResetPasswordStepTwoEvent extends Equatable {}

class ResetPasswordStepTwoReset extends ResetPasswordStepTwoEvent {
  final String passwordResetCode;
  final String password;
  final String passwordConfirm;

  ResetPasswordStepTwoReset({
    required this.passwordResetCode,
    required this.password,
    required this.passwordConfirm,
  });

  @override
  List<Object?> get props => [passwordResetCode, password, passwordConfirm];
}
