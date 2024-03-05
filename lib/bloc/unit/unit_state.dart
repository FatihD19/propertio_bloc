part of 'unit_bloc.dart';

sealed class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object> get props => [];
}

final class UnitInitial extends UnitState {}

final class UnitLoading extends UnitState {}

final class DetailUnitLoaded extends UnitState {
  final DetailunitResponseModel unitModel;

  const DetailUnitLoaded(this.unitModel);

  @override
  List<Object> get props => [unitModel];
}

final class UnitError extends UnitState {
  final String message;

  const UnitError(this.message);

  @override
  List<Object> get props => [message];
}
