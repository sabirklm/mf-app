part of 'mutual_fund_history_bloc.dart';

sealed class MutualFundHistoryEvent extends Equatable {
  const MutualFundHistoryEvent();

  @override
  List<Object> get props => [];
}

final class FetchMutualFundHistory extends MutualFundHistoryEvent {
  final String id;

  const FetchMutualFundHistory({required this.id}); 
}
