part of 'mutual_fund_history_bloc.dart';

sealed class MutualFundHistoryState extends Equatable {
  const MutualFundHistoryState();

  @override
  List<Object> get props => [];
}

final class MutualFundHistoryInitial extends MutualFundHistoryState {}

final class MutualFundHistoryLoading extends MutualFundHistoryState {}

final class MutualFundHistoryLoaded extends MutualFundHistoryState {
  final MutualFundNavHistory navHistory;

  const MutualFundHistoryLoaded({required this.navHistory});
}

final class MutualFundHistoryError extends MutualFundHistoryState {
  final CustomException error;

  const MutualFundHistoryError({required this.error});
}
