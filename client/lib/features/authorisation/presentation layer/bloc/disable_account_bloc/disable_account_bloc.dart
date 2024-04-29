// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/disable_account.dart';

part 'disable_account_event.dart';
part 'disable_account_state.dart';

class DisableAccountBloc
    extends Bloc<DisableAccountEvent, DisableAccountState> {
  final DisableAccountUseCase disableAccount;

  DisableAccountBloc({required this.disableAccount})
      : super(DisableAccountInitial()) {
    on<DisableAccountEvent>((event, emit) {});

    on<DisableMyAccountEvent>(_disableMyAccount);
  }

  void _disableMyAccount(
      DisableMyAccountEvent event, Emitter<DisableAccountState> emit) async {
    emit(DisableAccountLoading());
    final failureOrUnit = await disableAccount();
    failureOrUnit.fold(
      (failure) =>
          emit(DisableAccountError(message: mapFailureToMessage(failure))),
      (_) => emit(DisableAccountSuccess()),
    );
  }
}
