import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/currency_bloc/currency_event.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../data/model/currency.dart';
import '../../data/repo/repo.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, BaseState<ModelCurrency>> {
  final Addadvertisminterepo _addadvertisminterepo;
  
  CurrencyBloc(this._addadvertisminterepo) : super(BaseState()) {
    on<GetCurrencies>(_onGetCurrencies);
  }

  FutureOr<void> _onGetCurrencies(
    GetCurrencies event, 
    Emitter<BaseState<ModelCurrency>> emit
  ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _addadvertisminterepo.getcurrency();
    result.fold(
      (left) => emit(state.copyWith(
        status: Status.failure, 
        errorMessage: left.message
      )), 
      (right) => emit(state.copyWith(
        status: Status.success, 
        items: right
      ))
    );
  }
}
