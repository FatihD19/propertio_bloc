import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/datasource/auth_local_datasource.dart';
import 'package:propertio_bloc/data/datasource/auth_remote_datasource.dart';

import 'package:propertio_bloc/data/model/request/login_request_model.dart';
import 'package:propertio_bloc/data/model/request/register_request_model.dart';
import 'package:propertio_bloc/data/model/responses/login_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthBloc(this._authRemoteDataSource, this._authLocalDataSource)
      : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRemoteDataSource.login(event.data);
      result.fold(
        (l) => emit(AuthFailed(l)),
        (r) => emit(AuthSuccess(r)),
      );
    });
    on<AuthGetCurrentUser>((event, emit) async {
      try {
        emit(AuthLoading());
        final LoginRequestModel data =
            await _authLocalDataSource.getCredentialFromLocal();
        print('${data.password} ${data.email}');
        final result = await _authRemoteDataSource.login(data);

        result.fold(
          (l) => emit(AuthFailed(l)),
          (r) => emit(AuthSuccess(r)),
        );
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }
}
