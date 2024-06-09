part of 'modify_my_information_bloc.dart';

@immutable
sealed class ModifyMyInformationState extends Equatable {}

final class ModifyMyInformationInitial extends ModifyMyInformationState {
  @override
  List<Object?> get props => [];
}

final class ModifyMyInformationSuccess extends ModifyMyInformationState {
  User UpdatedUser;

  ModifyMyInformationSuccess(this.UpdatedUser);

  @override
  List<Object?> get props => [UpdatedUser];
}

final class ModifyMyInformationError extends ModifyMyInformationState {
  final String message;

  ModifyMyInformationError(this.message);

  @override
  List<Object?> get props => [message];
}
