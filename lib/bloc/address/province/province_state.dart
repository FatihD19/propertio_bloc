part of 'province_cubit.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<ProvinceResponseModel> provinces;

  ProvinceLoaded(this.provinces);

  @override
  List<Object> get props => [provinces];
}

class ProvinceError extends ProvinceState {
  final String message;

  ProvinceError(this.message);

  @override
  List<Object> get props => [message];
}


// class AddressState extends Equatable {
//   final List<ProvinceResponseModel> provinces;
//   final List<CitiesResponseModel> cities;
//   final String selectedProvinceId;

//   AddressState({
//     required this.provinces,
//     required this.cities,
//     required this.selectedProvinceId,
//   });

//   @override
//   List<Object?> get props => [provinces, cities, selectedProvinceId];

//   AddressState copyWith({
//     List<ProvinceResponseModel>? provinces,
//     List<CitiesResponseModel>? cities,
//     String? selectedProvinceId,
//   }) {
//     return AddressState(
//       provinces: provinces ?? this.provinces,
//       cities: cities ?? this.cities,
//       selectedProvinceId: selectedProvinceId ?? this.selectedProvinceId,
//     );
//   }
// }
