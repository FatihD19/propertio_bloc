part of 'unit_bloc.dart';

sealed class UnitEvent extends Equatable {
  const UnitEvent();

  @override
  List<Object> get props => [];
}

class OnGetDetailUnit extends UnitEvent {
  final String idUnit;
  const OnGetDetailUnit(this.idUnit);

  @override
  List<Object> get props => [idUnit];
}
