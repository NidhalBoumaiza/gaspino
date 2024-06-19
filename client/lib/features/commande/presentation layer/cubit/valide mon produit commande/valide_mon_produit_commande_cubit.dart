import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/commande.dart';
import '../../../domain layer/usecases/update_product_status_to_delivred.dart';

part 'valide_mon_produit_commande_state.dart';

class ValideMonProduitCommandeCubit
    extends Cubit<ValideMonProduitCommandeState> {
  final UpdateProductStatusToDelivred updateProductStatusToDelivered;

  ValideMonProduitCommandeCubit({required this.updateProductStatusToDelivered})
      : super(ValideMonProduitCommandeInitial());

  Future<void> onUpdateProductStatusToDelivered(
      {required String commandeId,
      required String productId,
      required List<Commande> commandes}) async {
    emit(ValideMonProduitCommandeLoading());
    final failureOrSuccess =
        await updateProductStatusToDelivered(commandeId, productId);
    failureOrSuccess.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(ValideMonProduitCommandeUnauthorized());
        } else {
          emit(ValideMonProduitCommandeError(
              message: mapFailureToMessage(failure)));
        }
      },
      (_) {
        for (var commande in commandes) {
          if (commande.id == commandeId) {
            for (var product in commande.products) {
              if (product.product.id == productId) {
                product.orderedProductStatus =
                    'delivered'; // Update the status here
                break;
              }
            }
          }
        }
        emit(ValideMonProduitCommandeSuccess(commande: commandes));
      },
    );
  }
}
