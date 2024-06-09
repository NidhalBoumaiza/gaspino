import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain layer/entities/user.dart';
import '../../../domain layer/usecases/get_cached_user_info.dart';

part 'get_cached_user_event.dart';
part 'get_cached_user_state.dart';

class GetCachedUserBloc extends Bloc<GetCachedUserEvent, GetCachedUserState> {
  GetCachedUserInfoUseCase getCachedUserInfoUseCase;

  GetCachedUserBloc({required this.getCachedUserInfoUseCase})
      : super(GetCachedUserInitial()) {
    on<GetCachedUserEvent>((event, emit) {});
    on<GetCachedUser>(_getCachedUser);
  }

  void _getCachedUser(
      GetCachedUser event, Emitter<GetCachedUserState> emit) async {
    emit(GetCachedUserLoading());
    final userOrFailure = await getCachedUserInfoUseCase();
    userOrFailure.fold(
      (failure) => emit(GetCachedUserError(message: EmptyCacheFailure.message)),
      (user) => emit(GetCachedUserLoaded(user: user)),
    );
  }
}
