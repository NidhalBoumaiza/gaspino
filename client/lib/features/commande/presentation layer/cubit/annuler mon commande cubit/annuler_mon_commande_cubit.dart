import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/commande.dart';
import '../../../domain layer/usecases/cancel_one_product_from_commande.dart';

part 'annuler_mon_commande_state.dart';

class AnnulerMonCommandeCubit extends Cubit<AnnulerMonCommandeState> {
  final CancelOneProductFromCommande cancelOneProductFromCommande;

  AnnulerMonCommandeCubit({required this.cancelOneProductFromCommande})
      : super(AnnulerMonCommandeInitial());

  Future<void> cancelOneProductFromCommandeCubit({
    required String commandeId,
    required String productId,
    required List<Commande> commandes,
  }) async {
    emit(AnnulerMonCommandeLoading());
    final failureOrSuccess =
        await cancelOneProductFromCommande(commandeId, productId);
    failureOrSuccess.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(AnnulerMonCommandeUnauthorized());
        } else {
          emit(AnnulerMonCommandeError(message: mapFailureToMessage(failure)));
        }
      },
      (_) {
        for (var commande in commandes) {
          if (commande.id == commandeId) {
            for (var product in commande.products) {
              if (product.product.id == productId) {
                product.orderedProductStatus =
                    'cancelled'; // Update the status here
                break;
              }
            }
          }
        }
        print(commandes);
        emit(AnnulerMonCommandeSuccess(commande: commandes));
      },
    );
  }
}
