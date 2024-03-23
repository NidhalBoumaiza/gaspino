import 'package:equatable/equatable.dart';

class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class ServerMessageException extends Equatable implements Exception {
  static late String message;

  //const ServerMessageException({required String message});

  @override
  List<Object?> get props => [message];
}

class UnauthorizedException implements Exception {
  static late String message;

  const UnauthorizedException({required String message});

  @override
  List<Object?> get props => [message];
}
