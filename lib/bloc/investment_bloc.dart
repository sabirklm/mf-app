import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mf_ip/routes/app_routes.dart';

part 'investment_event.dart';
part 'investment_state.dart';

class InvestmentBloc extends Bloc<InvestmentEvent, InvestmentState> {
  InvestmentBloc() : super(InvestmentState()) {
    on<InvestNow>(_onInvestNow);
  }

  Future<void> _onInvestNow(
    InvestNow event,
    Emitter<InvestmentState> emit,
  ) async {
    emit(InvestmentState());
    try {
      emit(InvestmentState(status: CurrentInvestmentStatus.investing));
      await Future.delayed(Duration(seconds: 3));
      emit(InvestmentState(status: CurrentInvestmentStatus.invested));
      kPrint("Investing amount of ${event.amount}...");
    } catch (e) {
      kPrint("Error investing ....");
      emit(InvestmentState(status: CurrentInvestmentStatus.error));
    }
  }
}
