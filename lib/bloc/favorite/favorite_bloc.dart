import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/datasource/favortite_remote_datasource.dart';
import 'package:propertio_bloc/data/model/responses/project_favorite_response_model.dart';
import 'package:propertio_bloc/data/model/responses/property_favorite_response_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRemoteDataSource _favoriteRemoteDataSource;
  FavoriteBloc(this._favoriteRemoteDataSource) : super(FavoriteInitial()) {
    on<OnGetFavoriteProperty>((event, emit) async {
      emit(FavoriteLoading());
      final result =
          await _favoriteRemoteDataSource.getFavoriteProperty(page: event.page);
      result.fold(
        (l) => emit(FavoriteError(l)),
        (r) => emit(FavoritePropertyLoaded(r)),
      );
    });

    on<OnGetFavoriteProject>((event, emit) async {
      emit(FavoriteLoading());
      final result =
          await _favoriteRemoteDataSource.getFavoriteProject(page: event.page);
      result.fold(
        (l) => emit(FavoriteError(l)),
        (r) => emit(FavoriteProjectLoaded(r)),
      );
    });

    on<OnAddFavorite>((event, emit) async {
      emit(FavoriteLoading());
      final result = await _favoriteRemoteDataSource.postFavorite(
          propertyCode: event.propertyCode, projectCode: event.projectCode);
      if (result) {
        emit(FavoriteSuccessAdd());
      } else {
        emit(FavoriteError('Server Error'));
      }
    });

    on<OnDeleteFavorite>((event, emit) async {
      emit(FavoriteLoading());
      final result = await _favoriteRemoteDataSource.deleteFavorite(
          propertyCode: event.propertyCode, projectCode: event.projectCode);
      if (result) {
        emit(FavoriteSuccessDelete());
      } else {
        emit(FavoriteError('Server Error'));
      }
    });
  }
}
