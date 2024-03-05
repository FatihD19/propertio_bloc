part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoritePropertyLoaded extends FavoriteState {
  final PropertyFavoriteResponseModel favoriteProperty;

  const FavoritePropertyLoaded(this.favoriteProperty);

  @override
  List<Object> get props => [favoriteProperty];
}

final class FavoriteProjectLoaded extends FavoriteState {
  final ProjectFavoriteResponseModel favoriteProject;

  const FavoriteProjectLoaded(this.favoriteProject);

  @override
  List<Object> get props => [favoriteProject];
}

class FavoriteSuccessAdd extends FavoriteState {}

class FavoriteSuccessDelete extends FavoriteState {}

final class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
