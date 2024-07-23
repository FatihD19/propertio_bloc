part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoading extends HomePageState {}

final class HomePageLoaded extends HomePageState {
  final HomePageModel homePageModel;

  HomePageLoaded(this.homePageModel);

  @override
  List<Object> get props => [homePageModel];
}

final class HomePageError extends HomePageState {
  final String message;

  const HomePageError(this.message);

  @override
  List<Object> get props => [message];
}
