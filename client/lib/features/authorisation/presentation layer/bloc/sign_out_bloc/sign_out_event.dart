part of 'sign_out_bloc.dart';

abstract class SignOutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignOutMyAccountEvent extends SignOutEvent {}
