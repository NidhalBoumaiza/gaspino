part of 'get_cached_user_bloc.dart';

@immutable
sealed class GetCachedUserState extends Equatable {}

class GetCachedUserInitial extends GetCachedUserState {
  @override
  List<Object?> get props => [];
}

class GetCachedUserLoading extends GetCachedUserState {
  @override
  List<Object?> get props => [];
}

class GetCachedUserLoaded extends GetCachedUserState {
  final User user;

  GetCachedUserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetCachedUserError extends GetCachedUserState {
  late String message;

  GetCachedUserError({required this.message});

  @override
  List<Object?> get props => [message];
}
