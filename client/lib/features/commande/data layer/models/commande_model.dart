import '../../../authorisation/data layer/models/user_model.dart';
import '../../../authorisation/domain layer/entities/user.dart';
import '../../domain layer/entities/commande.dart';
import 'ordred_product_model.dart';

class CommandeModel extends Commande {
  CommandeModel(
    String id,
    List<OrderedProductModel> products,
    String commandeStatus,
    User? commandeOwner,
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
      json['commandeId'] ?? '',
      [OrderedProductModel.fromJson(json['product'])], // Changed this line
      json['commandeStatus'] ?? '',
      UserModel.fromJson(json['commandeOwner'] as Map<String, dynamic>),
      DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products
          .map((product) => (product as OrderedProductModel).toJson())
          .toList(),
      'commandeStatus': commandeStatus,
      'commandeOwner':
          commandeOwner != null ? (commandeOwner as UserModel).toJson() : null,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
