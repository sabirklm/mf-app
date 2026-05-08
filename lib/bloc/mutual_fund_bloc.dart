import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mf_ip/models/custom_error.dart';
import 'package:mf_ip/routes/app_routes.dart';
import 'package:mf_ip/service/mutual_fund_service.dart';

import '../models/mutual_fund.dart';

part 'mutual_fund_event.dart';
part 'mutual_fund_state.dart';

class MutualFundBloc extends Bloc<MutualFundEvent, MutualFundState> {
  final _mfSerice = MutualFundService();
  MutualFundBloc() : super(MutualFundInitial()) {
    on<FetchMutualFunds>(_onFetchMutualFunds);
    on<SearchMutualFunds>(_onSearchMutualFunds);
    //SearchMutualFunds
  }

  FutureOr<void> _onFetchMutualFunds(
    FetchMutualFunds event,
    Emitter<MutualFundState> emit,
  ) async {
    try {
      emit(MutualFundLoading());
      var data = await _mfSerice.getMutualFunds();
      emit(MutualFundLoaded(data));
    } on SocketException {
      emit(MutualFundError(CustomException("No internet connection.")));
    } catch (e) {
      kPrint(e);
      if (e is CustomException) {
        emit(MutualFundError(e));
      }
      emit(MutualFundError(CustomException("Unknown Error occurred.")));
    }
  }

  Future<void> _onSearchMutualFunds(
    SearchMutualFunds event,
    Emitter<MutualFundState> emit,
  ) async {
    if (event.userInput.trim().isEmpty) {
      return;
    }
    emit(MutualFundLoading());
    try {
      var allFunds = await _mfSerice.getMutualFunds();

      var searchResult = allFunds
          .where(
            (element) => element.schemeName!.toLowerCase().contains(
              event.userInput.toLowerCase(),
            ),
          )
          .toList();
      emit(MutualFundLoaded(searchResult));
    } on SocketException {
      emit(MutualFundError(CustomException("No internet connection.")));
    } catch (e) {
      kPrint(e);
      if (e is CustomException) {
        emit(MutualFundError(e));
      }
      emit(MutualFundError(CustomException("Unknown Error occurred.")));
    }
  }
}
