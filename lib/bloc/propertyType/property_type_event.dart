part of 'property_type_bloc.dart';

sealed class PropertyTypeEvent extends Equatable {
  const PropertyTypeEvent();

  @override
  List<Object> get props => [];
}

class OnGetPropertyType extends PropertyTypeEvent {}
