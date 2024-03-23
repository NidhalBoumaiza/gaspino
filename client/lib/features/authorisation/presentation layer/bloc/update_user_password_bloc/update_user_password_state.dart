part of 'update_user_password_bloc.dart';

abstract class UpdateUserPasswordState extends Equatable {}

final class UpdateUserPasswordInitial extends UpdateUserPasswordState {
  @override
  List<Object?> get props => [];
}

final class UpdateUserPasswordLoading extends UpdateUserPasswordState {
  @override
  List<Object?> get props => [];
}

final class UpdateUserPasswordSuccess extends UpdateUserPasswordState {
  final String message;

  UpdateUserPasswordSuccess(this.message);

  @override
  List<Object?> get props => [];
}

final class UpdateUserPasswordError extends UpdateUserPasswordState {
  final String message;

  UpdateUserPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
