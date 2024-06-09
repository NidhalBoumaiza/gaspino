part of 'new_password_cubit.dart';

@immutable
class NewPasswordState extends Equatable {
  late bool isVisible = false;

  NewPasswordState({
    required this.isVisible,
  });

  @override
  List<Object?> get props => [isVisible];
}
