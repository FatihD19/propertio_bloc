part of 'cities_cubit.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

final class CitiesInitial extends CitiesState {}

final class CitiesLoading extends CitiesState {}

final class CitiesLoaded extends CitiesState {
  final List<CitiesResponseModel> cities;

  CitiesLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}

final class CitiesError extends CitiesState {
  final String message;

  CitiesError(this.message);

  @override
  List<Object> get props => [message];
}
