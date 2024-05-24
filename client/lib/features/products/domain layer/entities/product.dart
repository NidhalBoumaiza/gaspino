import 'package:equatable/equatable.dart';

import '../../../authorisation/domain layer/entities/user.dart';

class Product extends Equatable {
  late final String id;
  late List<String> productPictures;
  late String name;
  late String? description;
  late num? priceBeforeReduction;
  late num priceAfterReduction;
  late num quantity;
  late DateTime expirationDate;
  late List<DateTime?>? recoveryDate;
  late User productOwner;
  late Location location;
  late bool expired;
  late DateTime createdAt;

  Product(
    this.id,
    this.productPictures,
    this.name,
    this.description,
    this.priceBeforeReduction,
    this.priceAfterReduction,
    this.quantity,
    this.expirationDate,
    this.recoveryDate,
    this.productOwner,
    this.location,
    this.expired,
    this.createdAt,
  );

  Product.create({
    required this.name,
    required this.priceAfterReduction,
    required this.quantity,
    required this.expirationDate,
    required this.recoveryDate,
    required this.location,
    required this.productPictures,
    required this.description,
    required this.priceBeforeReduction,
  }) {
    id = '';
    expired = false;
    createdAt = DateTime.now();
    productOwner = User.create(
      firstName: '',
      lastName: '',
      phoneNumber: '',
      email: '',
      password: '',
      passwordConfirm: '',
    );
  }

  @override
  List<Object?> get props => [
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
      ];
}
