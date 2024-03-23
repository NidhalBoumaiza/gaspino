import 'package:client/core/strings.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  static final String message = OfflineFailureMessage;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  static final String message = ServerFailureMessage;

  @override
  List<Object?> get props => [message];
}

class EmptyCacheFailure extends Failure {
  static final String message = EmptyCacheFailureMessage;

  @override
  List<Object?> get props => [message];
}

class ServerMessageFailure extends Failure {
  static late String message;

  ServerMessageFailure();

  @override
  List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  static late String message;

  UnauthorizedFailure({required String message});

  @override
  List<Object?> get props => [message];
}
