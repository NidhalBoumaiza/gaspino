import '../../../authorisation/data layer/models/user_model.dart';
import '../../../authorisation/domain layer/entities/user.dart';
import '../../domain layer/entities/commande.dart';
import 'ordred_product_model.dart';

class CommandeModel extends Commande {
  CommandeModel(
    String id,
    List<OrderedProductModel> products,
    String commandeStatus,
    User commandeOwner,
    DateTime createdAt,
  ) : super(
          id,
          products,
          commandeStatus,
          commandeOwner,
          createdAt,
        );

  factory CommandeModel.fromJson(Map<String, dynamic> json) {
    return CommandeModel(
      json['_id'] ?? '',
      (json['products'] as List)
          .map((product) => OrderedProductModel.fromJson(product))
          .toList(),
      json['commandeStatus'] ?? '',
      UserModel.fromJson(json['commandeOwner'] as Map<String, dynamic>),
      DateTime.parse(json['createdAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products
          .map((product) => (product as OrderedProductModel).toJson())
          .toList(),
      'commandeStatus': commandeStatus,
      'commandeOwner': (commandeOwner as UserModel).toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
