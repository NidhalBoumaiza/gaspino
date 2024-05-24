import '../../../authorisation/data layer/models/user_model.dart';
import '../../../authorisation/domain layer/entities/user.dart';
import '../../domain layer/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
    String id,
    List<String> productPictures,
    String name,
    String? description,
    num? priceBeforeReduction,
    num priceAfterReduction,
    num quantity,
    DateTime expirationDate,
    List<DateTime>? recoveryDate,
    User productOwner,
    Location location,
    bool expired,
    DateTime createdAt,
  ) : super(
          id,
          productPictures,
          name,
          description,
          priceBeforeReduction,
          priceAfterReduction,
          quantity,
          expirationDate,
          recoveryDate,
          productOwner,
          location,
          expired,
          createdAt,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['_id'] ?? '',
      List<String>.from(json['productPictures'] ?? []),
      json['name'] ?? '',
      json['description'],
      json['priceBeforeReduction'],
      json['priceAfterReduction'] ?? 0,
      json['quantity'] ?? 0,
      DateTime.parse(json['expirationDate'] ?? ''),
      List<DateTime>.from(
          json['recoveryDate'].map((date) => DateTime.parse(date))),
      UserModel.fromJson(json['productOwner'] as Map<String, dynamic>),
      Location(
        json['location'] != null
            ? (json['location']['coordinates'] as List<dynamic>)
                .map((e) => num.parse(e.toString()))
                .toList()
            : [0.0, 0.0],
      ),
      json['expired'] ?? false,
      DateTime.parse(json['createdAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productPictures': productPictures,
      'name': name,
      'description': description,
      'priceBeforeReduction': priceBeforeReduction,
      'priceAfterReduction': priceAfterReduction,
      'quantity': quantity,
      'expirationDate': expirationDate.toIso8601String(),
      'recoveryDate':
          recoveryDate?.map((date) => date?.toIso8601String()).toList(),
      'productOwner': (productOwner as UserModel).toJson(),
      'location': {
        'coordinates': location.coordinates,
      },
      'expired': expired,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
