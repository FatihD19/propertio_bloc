import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/data/datasource/project_remote_datasource.dart';

import '../../helpers/dummy_data/propertio_data.dart';

class MockGetProjectRemoteDataSource extends Mock
    implements ProjectRemoteDataSource {}

void main() {
  late MockGetProjectRemoteDataSource mockGetProjectRemoteDataSource;
  late ProjectBloc projectBloc;

  setUp(() {
    mockGetProjectRemoteDataSource = MockGetProjectRemoteDataSource();
    projectBloc = ProjectBloc(mockGetProjectRemoteDataSource);
  });

  blocTest<ProjectBloc, ProjectState>(
    'emits [ProjectLoading, ProjectLoaded] when data is loaded successfully',
    build: () {
      when(() => mockGetProjectRemoteDataSource.getProject())
          .thenAnswer((_) async => Right(tListDataProject));
      return projectBloc;
    },
    act: (bloc) => bloc.add(OnGetProject()),
    expect: () => [
      ProjectLoading(),
      ProjectLoaded(tListDataProject),
    ],
  );

  blocTest<ProjectBloc, ProjectState>(
    'emits [ProjectLoading, ProjectLoaded] when data is loaded successfully',
    build: () {
      when(() => mockGetProjectRemoteDataSource
              .getDetailProject('gedung-pusat-perbelanjaan'))
          .thenAnswer((_) async => Right(tDetailProject));
      return projectBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailProject('gedung-pusat-perbelanjaan')),
    expect: () => [
      ProjectLoading(),
      ProjectDetailLoaded(tDetailProject),
    ],
  );
}
