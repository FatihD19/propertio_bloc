import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:propertio_mobile/data/datasource/properti_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_properti_response_model.dart';

import 'package:propertio_mobile/data/model/responses/list_properti_response_model.dart';

part 'properti_event.dart';
part 'properti_state.dart';

class PropertiBloc extends Bloc<PropertiEvent, PropertiState> {
  PropertiBloc() : super(PropertiInitial()) {
    on<PropertiEvent>((event, emit) async {
      if (event is OnGetProperti) {
        emit(PropertiLoading());
        final result = await PropertiRemoteDataSource().getProperti(
            isRent: event.isRent,
            query: event.query,
            page: event.page,
            type: event.type);
        result.fold(
          (l) => emit(PropertiError(l)),
          (r) => emit(PropertiLoaded(r)),
        );
      } else if (event is OnGetDetailProperti) {
        emit(PropertiLoading());
        final result =
            await PropertiRemoteDataSource().getDetailProperti(event.slug);
        result.fold(
          (l) => emit(PropertiError(l)),
          (r) => emit(PropertiDetailLoaded(r)),
        );
      }
    });
    // on<OnGetProperti>((event, emit) async {
    //   emit(PropertiLoading());
    //   final result = await PropertiRemoteDataSource().getProperti(
    //       isRent: event.isRent,
    //       query: event.query,
    //       page: event.page,
    //       type: event.type);
    //   result.fold(
    //     (l) => emit(PropertiError(l)),
    //     (r) => emit(PropertiLoaded(r)),
    //   );
    // });

    // on<OnGetDetailProperti>((event, emit) async {
    //   emit(PropertiLoading());
    //   final result =
    //       await PropertiRemoteDataSource().getDetailProperti(event.slug);
    //   result.fold(
    //     (l) => emit(PropertiError(l)),
    //     (r) => emit(PropertiDetailLoaded(r)),
    //   );
    // });
  }
}
