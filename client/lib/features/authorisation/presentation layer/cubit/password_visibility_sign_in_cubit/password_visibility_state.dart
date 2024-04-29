part of 'password_visibility_cubit.dart';

@immutable
class PasswordVisibilityState extends Equatable {
  late bool isVisible = false;

  PasswordVisibilityState({
    required this.isVisible,
  });

  @override
  List<Object?> get props => [isVisible];
}
