import 'package:equatable/equatable.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
  
  @override
  List<Object?> get props => [];
}

class GetCurrencies extends CurrencyEvent {
  const GetCurrencies();
  
  @override
  List<Object?> get props => [];
}
