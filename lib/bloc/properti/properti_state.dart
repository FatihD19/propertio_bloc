part of 'properti_bloc.dart';

sealed class PropertiState extends Equatable {
  const PropertiState();

  @override
  List<Object> get props => [];
}

final class PropertiInitial extends PropertiState {}

final class PropertiLoading extends PropertiState {}

final class PropertiLoaded extends PropertiState {
  final ListPropertyModel listPropertiModel;

  const PropertiLoaded(this.listPropertiModel);

  @override
  List<Object> get props => [listPropertiModel];
}

final class PropertiDetailLoaded extends PropertiState {
  final DetailPropertiResponseModel propertiModel;

  const PropertiDetailLoaded(this.propertiModel);

  @override
  List<Object> get props => [propertiModel];
}

// final class PropertiDetailLoaded extends PropertiLoaded {
//   final DetailPropertiResponseModel propertiModel;

//   const PropertiDetailLoaded(
//     this.propertiModel,
//     ListPropertyModel listPropertiModel,
//   ) : super(listPropertiModel);

//   @override
//   List<Object> get props => [propertiModel, listPropertiModel];
// }

final class PropertiError extends PropertiState {
  final String message;

  const PropertiError(this.message);

  @override
  List<Object> get props => [message];
}
