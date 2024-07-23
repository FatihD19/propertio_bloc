import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:propertio_bloc/bloc/auth/auth_bloc.dart';
import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';
import 'package:propertio_bloc/data/datasource/auth_remote_datasource.dart';
import 'package:propertio_bloc/data/model/request/login_request_model.dart';

import '../../helpers/dummy_data/propertio_data.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    authBloc = AuthBloc(mockAuthRemoteDataSource, mockAuthLocalDataSource);
  });

  final loginForm = LoginRequestModel(
    email: 'user@mail.com',
    password: '11111111',
  );
  final wrongLogin = LoginRequestModel(
    email: 'false@mail.com',
    password: '2false111111',
  );

  final nullLoginForm = LoginRequestModel(
    email: '',
    password: '',
  );
  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login is successful',
    build: () {
      when(() => mockAuthRemoteDataSource.login(loginForm))
          .thenAnswer((_) async => Right(tLoginData));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthLogin(loginForm)),
    expect: () => [
      AuthLoading(),
      AuthSuccess(tLoginData),
    ],
  );
  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login is failed',
    build: () {
      when(() => mockAuthRemoteDataSource.login(wrongLogin))
          .thenAnswer((_) async => Left('Error'));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthLogin(wrongLogin)),
    expect: () => [
      AuthLoading(),
      AuthFailed('Error'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when AuthGetCurrentUser is successful',
    build: () {
      when(() => mockAuthLocalDataSource.getCredentialFromLocal())
          .thenAnswer((_) async => loginForm);

      when(() => mockAuthRemoteDataSource.login(loginForm))
          .thenAnswer((_) async => Right(tLoginData));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthGetCurrentUser()),
    expect: () => [
      AuthLoading(),
      AuthSuccess(tLoginData),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when User not yet login (data login is null)',
    build: () {
      when(() => mockAuthLocalDataSource.getCredentialFromLocal())
          .thenAnswer((_) async => nullLoginForm);

      when(() => mockAuthRemoteDataSource.login(nullLoginForm))
          .thenAnswer((_) async => Left('data login is null'));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthGetCurrentUser()),
    expect: () => [
      AuthLoading(),
      AuthFailed('data login is null'),
    ],
  );
}
