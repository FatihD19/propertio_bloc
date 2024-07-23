import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:propertio_bloc/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_bloc/data/datasource/homepage_remote_datasource.dart';

import '../../helpers/dummy_data/propertio_data.dart';

class MockGetHomePageRemoteDataSource extends Mock
    implements HomePageRemoteDataSource {}

void main() {
  late MockGetHomePageRemoteDataSource mockGetHomePageRemoteDataSource;
  late HomePageBloc homePageBloc;

  setUp(() {
    mockGetHomePageRemoteDataSource = MockGetHomePageRemoteDataSource();
    homePageBloc = HomePageBloc(mockGetHomePageRemoteDataSource);
  });

  blocTest<HomePageBloc, HomePageState>(
    'emits [HomePageLoading, HomePageLoaded] when data is loaded successfully',
    build: () {
      when(() => mockGetHomePageRemoteDataSource.getHomePage())
          .thenAnswer((_) async => Right(tDataHomePage));
      return homePageBloc;
    },
    act: (bloc) => bloc.add(OnGetHomePage()),
    expect: () => [
      HomePageLoading(),
      HomePageLoaded(tDataHomePage),
    ],
  );

  blocTest<HomePageBloc, HomePageState>(
    'emits [HomePageLoading, HomePageError] when data is not loaded successfully',
    build: () {
      when(() => mockGetHomePageRemoteDataSource.getHomePage())
          .thenAnswer((_) async => Left('Error'));
      return homePageBloc;
    },
    act: (bloc) => bloc.add(OnGetHomePage()),
    expect: () => [
      HomePageLoading(),
      HomePageError('Error'),
    ],
  );
}
