part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {}

final class SignUpButtonPressed extends SignUpEvent {
  late User user;

  SignUpButtonPressed({required this.user});

  @override
  List<Object?> get props => [user];
}
