import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/product.dart';
import '../../../domain layer/usecases/get_my_products.dart';
import '../../../domain layer/usecases/refresh_my_products.dart';

part 'get_my_products_event.dart';
part 'get_my_products_state.dart';

class GetMyProductsBloc extends Bloc<GetMyProductsEvent, GetMyProductsState> {
  final GetMyProductsUseCase getAllMyProductsUseCase;
  final RefreshMyProductsUseCase refreshMyProductsUseCase;

  GetMyProductsBloc(
      {required this.getAllMyProductsUseCase,
      required this.refreshMyProductsUseCase})
      : super(GetMyProductsInitial()) {
    on<GetMyProducts>(_getMyProducts);
    on<GetMyProductsRefresh>(_refreshMyProducts);
  }

  Future<void> _getMyProducts(
      GetMyProducts event, Emitter<GetMyProductsState> emit) async {
    emit(GetMyProductsLoading());
    final failureOrMyProducts = await getAllMyProductsUseCase();
    failureOrMyProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetMyProductsUnauthorized());
      } else {
        emit(GetMyProductsError(message: mapFailureToMessage(failure)));
      }
    }, (products) => emit(GetMyProductsLoaded(products: products)));
  }

  Future<void> _refreshMyProducts(
      GetMyProductsRefresh event, Emitter<GetMyProductsState> emit) async {
    emit(GetMyProductsLoading());
    final failureOrMyProducts = await refreshMyProductsUseCase();
    failureOrMyProducts.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetMyProductsUnauthorized());
      } else {
        emit(GetMyProductsError(message: mapFailureToMessage(failure)));
      }
    }, (products) => emit(GetMyProductsLoaded(products: products)));
  }
}
