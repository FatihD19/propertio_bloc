part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class OnGetFavoriteProperty extends FavoriteEvent {
  int? page;

  OnGetFavoriteProperty({this.page});

  @override
  List<Object> get props => [
        {page}
      ];
}

class OnGetFavoriteProject extends FavoriteEvent {
  int? page;

  OnGetFavoriteProject({this.page});

  @override
  List<Object> get props => [
        {page}
      ];
}

class OnAddFavorite extends FavoriteEvent {
  String? propertyCode;
  String? projectCode;

  OnAddFavorite({this.propertyCode, this.projectCode});

  @override
  List<Object> get props => [
        {propertyCode, projectCode}
      ];
}

class OnDeleteFavorite extends FavoriteEvent {
  String? propertyCode;
  String? projectCode;

  OnDeleteFavorite({this.propertyCode, this.projectCode});

  @override
  List<Object> get props => [
        {propertyCode, projectCode}
      ];
}
