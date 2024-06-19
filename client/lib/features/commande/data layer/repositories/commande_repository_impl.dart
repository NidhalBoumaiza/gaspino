import 'package:client/core/error/failures.dart';
import 'package:client/features/commande/domain%20layer/entities/commande.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain layer/repositories/commande_repository.dart';
import '../data sources/commande_local_data_source.dart';
import '../data sources/commande_remote_data_source.dart';

class CommandeRepositoryImpl implements CommandeRepository {
  final CommandeRemoteDataSource commandeRemoteDataSource;
  final CommandeLocalDataSource commandeLocalDataSource;
  final NetworkInfo networkInfo;

  CommandeRepositoryImpl({
    required this.commandeRemoteDataSource,
    required this.networkInfo,
    required this.commandeLocalDataSource,
  });

  @override
  Future<Either<Failure, Unit>> passerCommande(dynamic commande) async {
    // List<OrderedProductModel> orderedProductModels = commande.products
    //     .map((product) => OrderedProductModel(
    //           product.product,
    //           product.quantity,
    //           product.orderedProductStatus,
    //         ))
    //     .toList();
    //
    // CommandeModel commandeModel = CommandeModel(
    //   commande.id ?? "",
    //   orderedProductModels,
    //   commande.commandeStatus ?? "",
    //   commande.commandeOwner,
    //   commande.createdAt ?? DateTime.now(),
    // );

    if (await networkInfo.isConnected) {
      try {
        await commandeRemoteDataSource.passerCommande(commande);
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
  Future<Either<Failure, List<Commande>>> getMyCommandes() async {
    if (await networkInfo.isConnected) {
      try {
        final commandes = await commandeRemoteDataSource.getMyCommandes();
        commandeLocalDataSource.cacheMyCommandes(commandes);
        return Right(commandes);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      try {
        final localCommandes = await commandeLocalDataSource.getMyCommandes();
        return Right(localCommandes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelOneProductFromCommande(
      String commandeId, String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await commandeRemoteDataSource.cancelOneProductFromCommande(
            commandeId, productId);
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
  Future<Either<Failure, List<Commande>>> getWhoCommandedMyProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final commandes =
            await commandeRemoteDataSource.getWhoCommandedMyProduct();
        commandeLocalDataSource.cacheWhoCommandedMyProduct(commandes);
        return Right(commandes);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      try {
        final localCommandes =
            await commandeLocalDataSource.getWhoCommandedMyProduct();
        return Right(localCommandes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProductStatusToDelivered(
      String commandeId, String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await commandeRemoteDataSource.updateProductStatusToDelivered(
            commandeId, productId);
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
