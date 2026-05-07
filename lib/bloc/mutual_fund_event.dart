part of 'mutual_fund_bloc.dart';

sealed class MutualFundEvent extends Equatable {
  const MutualFundEvent();

  @override
  List<Object> get props => [];
}

final class FetchMutualFunds extends MutualFundEvent {}

final class RefreshMutualFund extends MutualFundEvent {
  final int schemeCode;

  const RefreshMutualFund({required this.schemeCode});
}
