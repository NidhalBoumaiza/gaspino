import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/passer_cammande_use_case.dart';

part 'passer_commande_event.dart';
part 'passer_commande_state.dart';

class PasserCommandeBloc
    extends Bloc<PasserCommandeEvent, PasserCommandeState> {
  PasserCommandeUseCase passerCommandeUseCase;

  PasserCommandeBloc({required this.passerCommandeUseCase})
      : super(PasserCommandeInitial()) {
    on<PasserCommandeEvent>((event, emit) {});
    on<PasserCommande>(_passerCommande);
  }

  _passerCommande(
    PasserCommande event,
    Emitter<PasserCommandeState> emit,
  ) async {
    emit(PasserCommandeLoading());

    final failureOrCommande = await passerCommandeUseCase(event.products);
    failureOrCommande.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(PasserCommandeUnauthorised());
        } else {
          emit(PasserCommandeError(
            message: mapFailureToMessage(failure),
          ));
        }
      },
      (commande) {
        emit(PasserCommandeSuccess(message: 'Commande passée avec succès'));
      },
    );
  }
}
