import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/address_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/address_response_model.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final AddressRemoteDataSource _addressRemoteDataSource;
  CitiesCubit(this._addressRemoteDataSource) : super(CitiesInitial());

  Future<void> getCities(String provinceId) async {
    emit(CitiesLoading());
    final result = await _addressRemoteDataSource.getCity(provinceId);
    result.fold(
      (error) => emit(CitiesError(error)),
      (cities) => emit(CitiesLoaded([
        CitiesResponseModel(id: '0', name: 'Pilih Kota'),
        ...cities,
      ])),
    );
  }

  disposeCity() {
    emit(CitiesInitial());
  }
}
