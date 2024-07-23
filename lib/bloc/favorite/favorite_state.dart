part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteProjectLoaded extends FavoriteState {
  final ProjectFavoriteResponseModel favoriteProject;

  const FavoriteProjectLoaded(this.favoriteProject);

  @override
  List<Object> get props => [favoriteProject];
}

final class FavoriteSuccessAdd extends FavoriteState {
  final String projectCode;

  const FavoriteSuccessAdd(this.projectCode);

  @override
  List<Object> get props => [projectCode];
}

final class FavoriteSuccessDelete extends FavoriteState {
  final String projectCode;

  const FavoriteSuccessDelete(this.projectCode);

  @override
  List<Object> get props => [projectCode];
}

final class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
