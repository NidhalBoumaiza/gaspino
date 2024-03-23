part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState extends Equatable {}

final class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgetPasswordError extends ForgetPasswordState {
  final String message;

  ForgetPasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;

  ForgetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
