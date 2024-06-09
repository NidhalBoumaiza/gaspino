part of 'old_password_cubit.dart';

@immutable
class OldPasswordState extends Equatable {
  late bool isVisible = false;

  OldPasswordState({
    required this.isVisible,
  });

  @override
  List<Object?> get props => [isVisible];
}
