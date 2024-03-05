import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/address_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/address_response_model.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  final AddressRemoteDataSource _addressRemoteDataSource;

  ProvinceCubit(this._addressRemoteDataSource) : super(ProvinceInitial());

  Future<void> getProvinces() async {
    emit(ProvinceLoading());
    final result = await _addressRemoteDataSource.getProvince();
    result.fold(
      (error) => emit(ProvinceError(error)),
      (provinces) => emit(ProvinceLoaded([
        ProvinceResponseModel(id: '0', name: 'Pilih Provinsi'),
        ...provinces,
      ])),
    );
  }
}
// class AddressCubit extends Cubit<AddressState> {
//   final AddressRemoteDataSource _dataSource;

//   AddressCubit(this._dataSource)
//       : super(AddressState(
//           provinces: [],
//           cities: [],
//           selectedProvinceId: '',
//         ));

//   void getProvinces() async {
//     final result = await _dataSource.getProvince();
//     result.fold(
//       (error) => emit(state.copyWith(provinces: [])),
//       (provinces) => emit(state.copyWith(provinces: [
//         ProvinceResponseModel(id: '0', name: 'Pilih Provinsi'),
//         ...provinces,
//       ])),
//     );
//   }

//   void selectProvince(String provinceId) {
//     emit(state.copyWith(selectedProvinceId: provinceId));
//     getCities(provinceId);
//   }

//   void getCities(String provinceId) async {
//     final result = await _dataSource.getCity(provinceId);
//     result.fold(
//       (error) => emit(state.copyWith(cities: [], selectedProvinceId: '')),
//       (cities) => emit(state.copyWith(cities: [
//         CitiesResponseModel(id: '0', name: 'Pilih Kota'),
//         ...cities,
//       ])),
//     );
//   }
// }
