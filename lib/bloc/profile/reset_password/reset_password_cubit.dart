import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/profile_remote_datasource.dart';
import 'package:propertio_mobile/data/model/request/udpate_profil_request_model.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ProfileRemoteDataSource profilRemoteDataSource;
  ResetPasswordCubit(this.profilRemoteDataSource)
      : super(ResetPasswordInitial());

  void resetPassword(ResetPasswordRequestModel resetPassword) async {
    emit(ResetPasswordLoading());
    final result = await profilRemoteDataSource.resetPassword(resetPassword);
    if (result) {
      emit(ResetPasswordSuccess('Berhasil mereset password'));
    } else {
      emit(ResetPasswordError('Gagal mereset password'));
    }
  }
}
