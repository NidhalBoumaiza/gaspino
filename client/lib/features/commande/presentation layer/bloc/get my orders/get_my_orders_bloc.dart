import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/commande.dart';
import '../../../domain layer/usecases/get_my_commandes_use_case.dart';

part 'get_my_orders_event.dart';
part 'get_my_orders_state.dart';

class GetMyOrdersBloc extends Bloc<GetMyOrdersEvent, GetMyOrdersState> {
  GetMyCommandesUseCase getMyCommandesUseCase;

  GetMyOrdersBloc({required this.getMyCommandesUseCase})
      : super(GetMyOrdersInitial()) {
    on<GetMyOrdersEvent>((event, emit) {});
    on<GetMyOrders>(_getMyOrders);
  }

  _getMyOrders(GetMyOrders event, Emitter<GetMyOrdersState> emit) async {
    emit(GetMyOrdersLoading());
    final failureOrCommandes = await getMyCommandesUseCase();
    failureOrCommandes.fold(
          (failure) {
        if (failure is UnauthorizedFailure) {
          emit(GetMyOrdersUnauthenticated());
        } else {
          emit(GetMyOrdersError(
            message: mapFailureToMessage(failure),
          ));
        }
      },
          (commandes) {
        emit(GetMyOrdersLoaded(commandes: commandes));
      },
    );
  }
}
