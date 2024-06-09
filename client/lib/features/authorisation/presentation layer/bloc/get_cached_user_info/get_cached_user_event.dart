part of 'get_cached_user_bloc.dart';

@immutable
sealed class GetCachedUserEvent extends Equatable {}

class GetCachedUser extends GetCachedUserEvent {
  late User user;

  @override
  List<Object?> get props => [user];
}
