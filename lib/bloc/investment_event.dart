part of 'investment_bloc.dart';

sealed class InvestmentEvent extends Equatable {
  const InvestmentEvent();

  @override
  List<Object> get props => [];
}

final class InvestNow extends InvestmentEvent {
  final double amount;
  final String mfIf; 

  const InvestNow({required this.amount, required this.mfIf});
}
