import '../../../products/data layer/models/product_model.dart';
import '../../../products/domain layer/entities/product.dart';
import '../../domain layer/entities/ordred_product.dart';

class OrderedProductModel extends OrderedProduct {
  OrderedProductModel(
    Product product,
    int quantity,
    String orderedProductStatus,
  ) : super(
          product,
          quantity,
          orderedProductStatus,
        );

  factory OrderedProductModel.fromJson(Map<String, dynamic> json) {
    return OrderedProductModel(
      ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      json['quantity'] ?? 0,
      json['orderedProductStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
      'orderedProductStatus': orderedProductStatus,
    };
  }
}
