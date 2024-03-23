part of 'sign_out_bloc.dart';

abstract class SignOutState extends Equatable {}

final class SignOutInitial extends SignOutState {
  @override
  List<Object?> get props => [];
}

final class SignOutLoading extends SignOutState {
  @override
  List<Object?> get props => [];
}

final class SignOutSuccess extends SignOutState {
  @override
  List<Object?> get props => [];
}

final class SignOutError extends SignOutState {
  final String message;

  SignOutError({required this.message});

  @override
  List<Object?> get props => [message];
}
