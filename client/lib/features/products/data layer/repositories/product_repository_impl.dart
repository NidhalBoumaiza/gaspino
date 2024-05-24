import 'package:client/core/error/failures.dart';
import 'package:client/features/products/data%20layer/models/product_model.dart';
import 'package:client/features/products/domain%20layer/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain layer/repositories/product_repository.dart';
import '../data sources/product_local_data_souce.dart';
import '../data sources/product_remote_data_source.dart';

class ProductReopositryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductReopositryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    ProductModel productModel = ProductModel(
      product.id ?? "",
      product.productPictures,
      product.name,
      product.description,
      product.priceBeforeReduction,
      product.priceAfterReduction,
      product.quantity,
      product.expirationDate,
      product.recoveryDate?.map((date) => date ?? DateTime.now()).toList(),
      product.productOwner,
      product.location,
      product.expired,
      product.createdAt,
    );
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.addProduct(productModel);

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
  Future<Either<Failure, List<Product>>> getAllProductsWithinDistance(
      num distance) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource
            .getAllProductsWithinDistance(distance);
        productLocalDataSource.cacheProductsWithinDistance(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      try {
        final localProducts =
            await productLocalDataSource.getProductsWithinDistance();
        return Right(localProducts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMyProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        // await productRemoteDataSource.deleteMyProduct(id);

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
  Future<Either<Failure, List<Product>>> getMyProducts() async {
    if (await networkInfo.isConnected) {
      try {
        // final products = await productRemoteDataSource.getMyProducts();
        // productLocalDataSource.cacheMyProduct(products);
        // return Right(products);
        return Left(ServerFailure());
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
  Future<Either<Failure, List<Product>>> searchProductByName(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        // final products = await productRemoteDataSource.searchProductByName(name);
        // return Right(products);
        return Left(ServerFailure());
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
  Future<Either<Failure, Product>> updateMyProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        // final updatedProduct = await productRemoteDataSource.updateMyProduct(product);
        // return Right(updatedProduct);
        return Left(ServerFailure());
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
  Future<Either<Failure, List<Product>>>
      getAllProductsWithinDistanceExpiresToday(num distance) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource
            .getAllProductsWithinDistanceExpiresToday(distance);
        productLocalDataSource.cacheProductsWithinDistance(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      try {
        final localProducts =
            await productLocalDataSource.getProductsWithinDistance();
        return Right(localProducts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
