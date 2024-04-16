part of 'reset_confirm_password_visibility_cubit.dart';

@immutable
class ResetConfirmPasswordVisibilityState extends Equatable {
  late bool isVisible = false;

  ResetConfirmPasswordVisibilityState({
    required this.isVisible,
  });

  List<Object?> get props => [isVisible];
}
