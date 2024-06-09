part of 'confirm_new_password_cubit.dart';

@immutable
class ConfirmNewPasswordState extends Equatable {
  late bool isVisible = false;

  ConfirmNewPasswordState({
    required this.isVisible,
  });

  @override
  List<Object?> get props => [isVisible];
}
