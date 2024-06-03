import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_quantity_state.dart';

class ProductQuantityCubit extends Cubit<ProductQuantityState> {
  ProductQuantityCubit() : super(ProductQuantityState(quantities: {}));

  void changeQuantity(String productId, int quantity) {
    final updatedQuantities = Map<String, int>.from(state.quantities);
    updatedQuantities[productId] = quantity;
    print(state.quantities);
    emit(ProductQuantityState(quantities: updatedQuantities));
  }
}
