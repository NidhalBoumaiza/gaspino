part of 'product_quantity_cubit.dart';

class ProductQuantityState extends Equatable {
  final Map<String, int> quantities;

  ProductQuantityState({required this.quantities});

  @override
  List<Object> get props => [quantities];

  int get totalQuantity {
    return quantities.values
        .fold(0, (previousValue, element) => previousValue + element);
  }
}
