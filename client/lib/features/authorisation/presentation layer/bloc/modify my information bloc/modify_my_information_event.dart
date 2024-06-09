part of 'modify_my_information_bloc.dart';

class ModifyMyInformationEvent extends Equatable {
  final User user;

  const ModifyMyInformationEvent(this.user);

  @override
  List<Object?> get props => [user];
}
