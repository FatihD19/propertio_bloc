part of 'property_type_bloc.dart';

sealed class PropertyTypeState extends Equatable {
  const PropertyTypeState();

  @override
  List<Object> get props => [];
}

final class PropertyTypeInitial extends PropertyTypeState {}

final class PropertyTypeLoading extends PropertyTypeState {}

final class PropertyTypeLoaded extends PropertyTypeState {
  final ListPropertyTypeResponseModel propertyTypeModel;

  const PropertyTypeLoaded(this.propertyTypeModel);

  @override
  List<Object> get props => [propertyTypeModel];
}

final class PropertyTypeError extends PropertyTypeState {
  final String message;

  const PropertyTypeError(this.message);

  @override
  List<Object> get props => [message];
}
