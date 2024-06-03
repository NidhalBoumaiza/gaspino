import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain layer/entities/ordred_product.dart';

part 'shopping_card_state.dart';

class ShoppingCardCubit extends Cubit<ShoppingCardState> {
  ShoppingCardCubit() : super(ShoppingCardState(ordredProducts: []));

  void addProduct(OrderedProduct product) {
    final updatedProducts = List<OrderedProduct>.from(state.ordredProducts);
    final index =
        updatedProducts.indexWhere((p) => p.product.id == product.product.id);

    if (index != -1) {
      // Product already exists, update the quantity
      final existingProduct = updatedProducts[index];
      final updatedProduct = OrderedProduct(
        existingProduct.product,
        (product.quantity - existingProduct.quantity) +
            existingProduct.quantity,
        existingProduct.orderedProductStatus,
      );
      updatedProducts[index] = updatedProduct;
    } else {
      // Product does not exist, add it to the list
      updatedProducts.add(product);
    }
    emit(ShoppingCardState(ordredProducts: updatedProducts));
  }

  void removeProduct(OrderedProduct product) {
    final updatedProducts = List<OrderedProduct>.from(state.ordredProducts);
    updatedProducts.removeWhere((p) => p.product.id == product.product.id);
    emit(ShoppingCardState(ordredProducts: updatedProducts));
  }
}
