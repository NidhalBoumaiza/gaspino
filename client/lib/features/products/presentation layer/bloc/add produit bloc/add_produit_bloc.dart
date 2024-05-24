import 'package:bloc/bloc.dart';
import 'package:client/features/products/domain%20layer/entities/product.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/add_product.dart';

part 'add_produit_event.dart';
part 'add_produit_state.dart';

class AddProduitBloc extends Bloc<AddProduitEvent, AddProduitState> {
  final AddProductUseCase addProduct;

  AddProduitBloc({required this.addProduct}) : super(AddProduitInitial()) {
    on<AddProduitEvent>((event, emit) {});
    on<AddProduitButtonPressed>(_addProduitButtonPressed);
  }

  _addProduitButtonPressed(
      AddProduitButtonPressed event, Emitter<AddProduitState> emit) async {
    emit(AddProduitLoading());
    final failureOrUnit = await addProduct(event.product);
    failureOrUnit.fold(
        (failure) =>
            emit(AddProduitError(message: mapFailureToMessage(failure))),
        (unit) =>
            emit(AddProduitSuccess(message: 'Produit ajouté avec succès')));
  }
}
