part of 'disable_account_bloc.dart';

abstract class DisableAccountState {}

final class DisableAccountInitial extends DisableAccountState {}

final class DisableAccountLoading extends DisableAccountState {}

final class DisableAccountSuccess extends DisableAccountState {}

final class DisableAccountError extends DisableAccountState {
  final String message;

  DisableAccountError({required this.message});
}
