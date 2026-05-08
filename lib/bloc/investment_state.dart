part of 'investment_bloc.dart';

enum CurrentInvestmentStatus { initial, investing, invested, error }

final class InvestmentState extends Equatable {
  final CurrentInvestmentStatus status; 
  
  const InvestmentState({
    this.status = CurrentInvestmentStatus.initial
  });

  @override
  List<Object> get props => [status];
}
