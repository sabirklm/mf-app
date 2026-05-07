part of 'mutual_fund_bloc.dart';

sealed class MutualFundState extends Equatable {
  const MutualFundState();

  @override
  List<Object?> get props => [];
}

final class MutualFundInitial extends MutualFundState {}

final class MutualFundLoading extends MutualFundState {}

final class MutualFundLoaded extends MutualFundState {
  final List<MutualFund> schemes;

  const MutualFundLoaded(this.schemes);

  @override
  List<Object?> get props => [schemes];
}

final class MutualFundError extends MutualFundState {
  final CustomException? error;

  const MutualFundError(this.error);

  @override
  List<Object?> get props => [error];
}
