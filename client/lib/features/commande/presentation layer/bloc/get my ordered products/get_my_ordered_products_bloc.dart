import 'package:bloc/bloc.dart';
import 'package:client/features/commande/domain%20layer/entities/commande.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/get_who_commande_my_product_use_case.dart';

part 'get_my_ordered_products_event.dart';
part 'get_my_ordered_products_state.dart';

class GetMyOrderedProductsBloc
    extends Bloc<GetMyOrderedProductsEvent, GetMyOrderedProductsState> {
  GetWhoCommandeMyProductUseCase getWhoOrderedProductsUseCase;

  GetMyOrderedProductsBloc({required this.getWhoOrderedProductsUseCase})
      : super(GetMyOrderedProductsInitial()) {
    on<GetMyOrderedProductsEvent>((event, emit) {});
    on<GetMyOrderedProducts>(_getMyOrderedProducts);
  }

  _getMyOrderedProducts(
    GetMyOrderedProducts event,
    Emitter<GetMyOrderedProductsState> emit,
  ) async {
    emit(GetMyOrderedProductsLoading());
    final failureOrCommandes = await getWhoOrderedProductsUseCase();
    failureOrCommandes.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(GetMyOrderedProductsNonAuthenticated());
        } else {
          emit(GetMyOrderedProductsError(
            message: mapFailureToMessage(failure),
          ));
        }
      },
      (commandes) {
        emit(GetMyOrderedProductsLoaded(orderedProducts: commandes));
      },
    );
  }
}
