part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {}

final class ForgetPasswordRequest extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordRequest({required this.email});

  @override
  List<Object?> get props => [email];
}
