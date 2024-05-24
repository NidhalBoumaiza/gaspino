// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:client/core/error/failures.dart';
import 'package:client/features/authorisation/domain%20layer/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain layer/repositories/user_repository.dart';
import '../data sources/user_local_data_source.dart';
import '../data sources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> signUp(User user) async {
    final UserModel userModel = UserModel(
      user.id ?? "",
      user.profilePicture ?? "",
      user.firstName,
      user.lastName,
      user.phoneNumber,
      user.email,
      user.password,
      user.passwordConfirm,
      user.location ?? Location([0.0, 0.0]),
      user.passwordResetCode ?? "",
      user.accountStatus ?? false,
    );
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.signUp(userModel);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.forgetPassword(email);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPasswordStepOne(
      String passwordResetCode) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.resetPasswordStepOne(passwordResetCode);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPasswordStepTwo(
      String passwordResetCode, String password, String passwordConfirm) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.resetPasswordStepTwo(
            passwordResetCode, password, passwordConfirm);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel =
            await userRemoteDataSource.signIn(email, password);
        await userLocalDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  //------------------------------------------------------------------------------
  /// NEXT METHODS ARE FOR AUTHENTICATED USERS
  @override
  Future<Either<Failure, Unit>> updateUserPassword(
      String oldPassword, String newPassword, String newPasswordConfirm) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.updateUserPassword(
            oldPassword, newPassword, newPasswordConfirm);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocation(Location location) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.updateLocation(location);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        await userLocalDataSource.signOut();
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> disableMyAccount() async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.disableMyAccount();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await userLocalDataSource.signOut();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
