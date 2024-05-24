part of 'bnv_cubit.dart';

@immutable
class BnvState extends Equatable {
  final int currentIndex;

  BnvState({
    required this.currentIndex,
  });

  @override
  List<Object?> get props => [currentIndex];
}
