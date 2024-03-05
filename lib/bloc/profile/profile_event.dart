part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OnGetProfile extends ProfileEvent {}

class OnDisposeProfile extends ProfileEvent {}
