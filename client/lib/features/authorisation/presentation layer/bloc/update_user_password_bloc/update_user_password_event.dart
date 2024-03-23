part of 'update_user_password_bloc.dart';

abstract class UpdateUserPasswordEvent extends Equatable {}

class UpdateUserPasswordEventPasswordChanging extends UpdateUserPasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirm;

  UpdateUserPasswordEventPasswordChanging(
      {required this.oldPassword,
      required this.newPassword,
      required this.newPasswordConfirm});

  @override
  List<Object?> get props => [oldPassword, newPassword, newPasswordConfirm];
}
