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
