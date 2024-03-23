import '../error/failures.dart';

mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return ServerFailure.message;
    case EmptyCacheFailure:
      return EmptyCacheFailure.message;
    case ServerMessageFailure:
      return ServerMessageFailure.message;
    case UnauthorizedFailure:
      return UnauthorizedFailure.message;
    case OfflineFailure:
      return OfflineFailure.message;
  }
}
