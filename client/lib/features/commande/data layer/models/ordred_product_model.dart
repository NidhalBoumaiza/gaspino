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
    print("json");
    print(json);
    return OrderedProductModel(
      ProductModel.fromJson(json['productId'] as Map<String, dynamic>),
      json['quantity'] ?? 0,
      json['ordredProduitStatus'] ?? '',
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
