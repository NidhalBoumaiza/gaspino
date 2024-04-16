part of 'reset_password_visibility_cubit.dart';

@immutable
class ResetPasswordVisibilityState extends Equatable {
  late bool isVisible = false;

  ResetPasswordVisibilityState({
    required this.isVisible,
  });

  List<Object?> get props => [isVisible];
}
