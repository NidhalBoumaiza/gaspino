import 'package:equatable/equatable.dart';

import '../../../products/domain layer/entities/product.dart';

class OrderedProduct extends Equatable {
  late Product product;
  late int quantity;
  late String orderedProductStatus;

  OrderedProduct(
    this.product,
    this.quantity,
    this.orderedProductStatus,
  );

  @override
  List<Object> get props => [product, quantity, orderedProductStatus];
}
