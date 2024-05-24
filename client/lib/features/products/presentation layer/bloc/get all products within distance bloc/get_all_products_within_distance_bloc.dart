import 'package:bloc/bloc.dart';
import 'package:client/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/product.dart';
import '../../../domain layer/usecases/get_all_products_within_distance.dart';

part 'get_all_products_within_distance_event.dart';
part 'get_all_products_within_distance_state.dart';

class GetProductsWithinDistanceBloc extends Bloc<GetProductsWithinDistanceEvent,
    GetProductsWithinDistanceState> {
  final GetAllProductsWithinDistanceUseCase getAllProductsWithinDistanceUseCase;

  GetProductsWithinDistanceBloc(
      {required this.getAllProductsWithinDistanceUseCase})
      : super(GetProductsWithinDistanceInitial()) {
    on<GetProductsWithinDistanceEvent>((event, emit) {});
    on<GetProductsWithinDistancee>(_getProductsWithinDistance);
    on<RefreshGetProductsWithinDistancee>(_refreshGetProductsWithinDistance);
  }

  _getProductsWithinDistance(GetProductsWithinDistancee event, emit) async {
    emit(GetProductsWithinDistanceLoading());
    final failureOrProducts =
        await getAllProductsWithinDistanceUseCase(event.distance!);

    failureOrProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetProductsWithinDistanceUnauthorized());
      } else {
        emit(GetProductsWithinDistanceError(
            message: mapFailureToMessage(failure)));
      }
    }, (products) => emit(GetProductsWithinDistanceLoaded(products: products)));
  }

  _refreshGetProductsWithinDistance(
      RefreshGetProductsWithinDistancee event, emit) async {
    emit(GetProductsWithinDistanceLoading());
    final failureOrProducts =
        await getAllProductsWithinDistanceUseCase(event.distance!);

    failureOrProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetProductsWithinDistanceUnauthorized());
      } else {
        emit(GetProductsWithinDistanceError(
            message: mapFailureToMessage(failure)));
      }
    }, (products) => emit(GetProductsWithinDistanceLoaded(products: products)));
  }
}
