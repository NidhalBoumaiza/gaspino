import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/product.dart';
import '../../../domain layer/usecases/get_all_products_within_distance_expires_today.dart';

part 'get_products_expires_today_event.dart';
part 'get_products_expires_today_state.dart';

class GetProductsExpiresTodayBloc
    extends Bloc<GetProductsEpiresTodayEvent, GetProductsExpiresTodayState> {
  GetAllProductsWithinDistanceExpiresTodayUseCase
  getAllProductsWithinDistanceExpiresTodayUseCase;

  GetProductsExpiresTodayBloc(
      {required this.getAllProductsWithinDistanceExpiresTodayUseCase})
      : super(GetProductsExpiresTodayInitial()) {
    on<GetProductsEpiresTodayEvent>((event, emit) {});
    on<GetProductsWithinDistanceee>(_getProductsWithinDistanceee);
    on<RefreshGetProductsWithinDistanceee>(_refreshGetProductsWithinDistance);
  }

  _getProductsWithinDistanceee(GetProductsWithinDistanceee event, emit) async {
    emit(GetProductsExpiresTodayLoading());
    final failureOrProducts =
    await getAllProductsWithinDistanceExpiresTodayUseCase(event.distance!);

    failureOrProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetProductsExpiresTodayUnauthorized());
      } else {
        emit(GetProductsExpiresTodayError(
            message: mapFailureToMessage(failure)));
      }
    }, (products) => emit(GetProductsExpiresTodayLoaded(products: products)));
  }

  _refreshGetProductsWithinDistance(RefreshGetProductsWithinDistanceee event,
      emit) async {
    emit(GetProductsExpiresTodayLoading());
    final failureOrProducts =
    await getAllProductsWithinDistanceExpiresTodayUseCase(event.distance!);

    failureOrProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetProductsExpiresTodayUnauthorized());
      } else {
        emit(GetProductsExpiresTodayError(
            message: mapFailureToMessage(failure)));
      }
    },
            (products) =>
            emit(GetProductsExpiresTodayLoaded(products: products)));
  }
}
