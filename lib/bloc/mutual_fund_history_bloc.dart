import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mf_ip/models/custom_error.dart';
import 'package:mf_ip/models/nav_history.dart';
import 'package:mf_ip/routes/app_routes.dart';
import 'package:mf_ip/service/mutual_fund_service.dart';

part 'mutual_fund_history_event.dart';
part 'mutual_fund_history_state.dart';

class MutualFundHistoryBloc
    extends Bloc<MutualFundHistoryEvent, MutualFundHistoryState> {
  final _mfService = MutualFundService();
  MutualFundHistoryBloc() : super(MutualFundHistoryInitial()) {
    on<FetchMutualFundHistory>(_onFetchMutualFundHistory);
  }

  FutureOr<void> _onFetchMutualFundHistory(
    FetchMutualFundHistory event,
    Emitter<MutualFundHistoryState> emit,
  ) async {
    try {
      var mfNavHistory = await _mfService.getNavHistory(event.id);
      emit(MutualFundHistoryLoaded(navHistory: mfNavHistory));
    } catch (e) {
      kPrint(e);
      emit(MutualFundHistoryError(error: CustomException("message")));
    }
  }
}
