import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/profile_remote_datasource.dart';
import 'package:propertio_mobile/data/model/request/udpate_profil_request_model.dart';
import 'package:propertio_mobile/data/model/responses/profil_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<OnGetProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await ProfileRemoteDataSource().getProfile();
      result.fold(
        (l) => emit(ProfileError(l)),
        (r) => emit(ProfileSuccess(r)),
      );
    });

    on<OnUpdateProfil>((event, emit) async {
      emit(ProfileLoading());
      final result =
          await ProfileRemoteDataSource().updateProfile(event.request);
      result.fold(
        (l) => emit(ProfileError(l)),
        (r) => emit(ProfileSuccess(r)),
      );
    });

    on<OnDisposeProfile>((event, emit) async {
      emit(ProfileError('Perlu Login'));
    });
  }
}
