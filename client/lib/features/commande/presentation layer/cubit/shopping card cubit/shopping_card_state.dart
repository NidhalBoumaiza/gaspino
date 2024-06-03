part of 'shopping_card_cubit.dart';

class ShoppingCardState extends Equatable {
  final List<OrderedProduct> ordredProducts;

  ShoppingCardState({required this.ordredProducts});

  @override
  List<Object> get props => [ordredProducts];

  int get totalQuantity {
    return ordredProducts.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return ordredProducts.fold(
        0.0,
        (sum, item) =>
            sum + (item.product.priceAfterReduction * item.quantity));
  }
}
