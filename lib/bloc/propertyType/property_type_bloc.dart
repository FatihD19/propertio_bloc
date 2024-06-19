import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/datasource/properti_remote_datasource.dart';
import 'package:propertio_bloc/data/model/responses/list_propertyType_Response_model.dart';

part 'property_type_event.dart';
part 'property_type_state.dart';

class PropertyTypeBloc extends Bloc<PropertyTypeEvent, PropertyTypeState> {
  final PropertiRemoteDataSource _propertiRemoteDataSource;
  PropertyTypeBloc(this._propertiRemoteDataSource)
      : super(PropertyTypeInitial()) {
    on<OnGetPropertyType>((event, emit) async {
      emit(PropertyTypeLoading());
      final result = await PropertiRemoteDataSource().getTipeProperti();
      result.fold(
        (l) => emit(PropertyTypeError(l)),
        (r) => emit(PropertyTypeLoaded(r)),
      );
    });
  }
}
