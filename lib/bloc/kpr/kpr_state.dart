part of 'kpr_cubit.dart';

sealed class KprState extends Equatable {
  const KprState();

  @override
  List<Object> get props => [];
}

final class KprInitial extends KprState {
  const KprInitial();

  @override
  List<Object> get props => [];
}

final class KprLoading extends KprState {}

final class KprError extends KprState {
  final String message;

  KprError(this.message);

  @override
  List<Object> get props => [message];
}

final class KprLoaded extends KprState {
  final LoanSimulationResult installmentResults;

  KprLoaded(this.installmentResults);

  @override
  List<Object> get props => [installmentResults];
}
