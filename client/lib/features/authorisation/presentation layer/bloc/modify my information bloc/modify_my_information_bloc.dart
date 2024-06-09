import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/user.dart';
import '../../../domain layer/usecases/modify_my_information.dart';

part 'modify_my_information_event.dart';
part 'modify_my_information_state.dart';

class ModifyMyInformationBloc
    extends Bloc<ModifyMyInformationEvent, ModifyMyInformationState> {
  ModifyMyInformationUseCase modifyMyInformationUseCase;

  ModifyMyInformationBloc({required this.modifyMyInformationUseCase})
      : super(ModifyMyInformationInitial()) {
    on<ModifyMyInformationEvent>(
      (event, emit) async {
        final updatedUserOrFailure =
            await modifyMyInformationUseCase.call(event.user);
        updatedUserOrFailure.fold(
          (failure) =>
              emit(ModifyMyInformationError(mapFailureToMessage(failure))),
          (updatedUser) => emit(ModifyMyInformationSuccess(updatedUser)),
        );
      },
    );
  }
}
