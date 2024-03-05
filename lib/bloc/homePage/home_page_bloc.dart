import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:propertio_mobile/data/datasource/homepage_remote_datasource.dart';

import 'package:propertio_mobile/data/model/responses/homepage_response_Model.dart';
import 'package:propertio_mobile/ui/pages/Home/home_page.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageRemoteDataSource _homePageRemoteDataSource;
  HomePageBloc(this._homePageRemoteDataSource) : super(HomePageInitial()) {
    on<OnGetHomePage>((event, emit) async {
      emit(HomePageLoading());
      final result = await _homePageRemoteDataSource.getHomePage();
      result.fold(
        (l) => emit(HomePageError(l)),
        (r) => emit(HomePageLoaded(r)),
      );
    });
  }
}
