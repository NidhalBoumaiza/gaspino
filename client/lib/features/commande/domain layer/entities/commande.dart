import 'package:equatable/equatable.dart';

import '../../../authorisation/domain layer/entities/user.dart';
import 'ordred_product.dart';

class Commande extends Equatable {
  late String id;
  late List<OrderedProduct> products = [];
  late String commandeStatus;
  late User commandeOwner;
  late DateTime createdAt;

  Commande(
    this.id,
    this.products,
    this.commandeStatus,
    this.commandeOwner,
    this.createdAt,
  );

  @override
  List<Object> get props =>
      [id, products, commandeStatus, commandeOwner, createdAt];
}
