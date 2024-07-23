import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:propertio_bloc/bloc/favorite/favorite_bloc.dart';
import 'package:propertio_bloc/data/datasource/favortite_remote_datasource.dart';

import '../../helpers/dummy_data/propertio_data.dart';

class MockFavoriteRemoteDataSource extends Mock
    implements FavoriteRemoteDataSource {}

void main() {
  late MockFavoriteRemoteDataSource mockFavoriteRemoteDataSource;
  late FavoriteBloc favoriteBloc;

  setUp(() {
    mockFavoriteRemoteDataSource = MockFavoriteRemoteDataSource();
    favoriteBloc = FavoriteBloc(mockFavoriteRemoteDataSource);
  });

  blocTest<FavoriteBloc, FavoriteState>(
    'emits [FavoriteLoading, FavoriteProjectLoaded] when data is loaded successfully',
    build: () {
      when(() => mockFavoriteRemoteDataSource.getFavoriteProject())
          .thenAnswer((_) async => Right(tListFavoriteProject));
      return favoriteBloc;
    },
    act: (bloc) => bloc.add(OnGetFavoriteProject()),
    expect: () => [
      FavoriteLoading(),
      FavoriteProjectLoaded(tListFavoriteProject),
    ],
  );

  blocTest<FavoriteBloc, FavoriteState>(
    'emits [FavoriteLoading,FavoriteSuccsessAdd] when data is added successfully',
    build: () {
      when(() => mockFavoriteRemoteDataSource.postFavorite(
              projectCode: 'PJ_Tanah-012024052266158'))
          .thenAnswer((_) async => true);
      return favoriteBloc;
    },
    act: (bloc) =>
        bloc.add(OnAddFavorite(projectCode: 'PJ_Tanah-012024052266158')),
    expect: () => [
      FavoriteLoading(),
      FavoriteSuccessAdd(),
    ],
  );

  blocTest<FavoriteBloc, FavoriteState>(
    'emits [FavoriteLoading,FavoriteSuccsessDelete] when data is deleted successfully',
    build: () {
      when(() => mockFavoriteRemoteDataSource.deleteFavorite(
              projectCode: 'PJ_Tanah-012024052266158'))
          .thenAnswer((_) async => true);
      return favoriteBloc;
    },
    act: (bloc) =>
        bloc.add(OnDeleteFavorite(projectCode: 'PJ_Tanah-012024052266158')),
    expect: () => [
      FavoriteLoading(),
      FavoriteSuccessDelete(),
    ],
  );
}
