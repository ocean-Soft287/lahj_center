
import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final int currencyID;
  final String currencyName;
  final String currencyEName;
  final String partName;
  final String partEName;
  final int partPrecision;
  final double rate;
  final String currencySymbol;
  final String totCurrencyName;
  final String totCurrencyEName;
  final String totPartName;
  final String totPartEName;
  final String pricesDigits;

  const Currency({
    required this.currencyID,
    required this.currencyName,
    required this.currencyEName,
    required this.partName,
    required this.partEName,
    required this.partPrecision,
    required this.rate,
    required this.currencySymbol,
    required this.totCurrencyName,
    required this.totCurrencyEName,
    required this.totPartName,
    required this.totPartEName,
    required this.pricesDigits,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyID: json['CurrencyID'],
      currencyName: json['CurrencyName'],
      currencyEName: json['CurrencyEName'],
      partName: json['PartName'],
      partEName: json['PartEName'],
      partPrecision: json['PartPrecition'],
      rate: json['Rate'].toDouble(),
      currencySymbol: json['CurrencySymbol'],
      totCurrencyName: json['TotCurrencyName'],
      totCurrencyEName: json['TotCurrencyEName'],
      totPartName: json['TotPartName'],
      totPartEName: json['TotPartEName'],
      pricesDigits: json['PricesDigits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CurrencyID': currencyID,
      'CurrencyName': currencyName,
      'CurrencyEName': currencyEName,
      'PartName': partName,
      'PartEName': partEName,
      'PartPrecition': partPrecision,
      'Rate': rate,
      'CurrencySymbol': currencySymbol,
      'TotCurrencyName': totCurrencyName,
      'TotCurrencyEName': totCurrencyEName,
      'TotPartName': totPartName,
      'TotPartEName': totPartEName,
      'PricesDigits': pricesDigits,
    };
  }

  @override
  List<Object> get props => [
    currencyID,
    currencyName,
    currencyEName,
    partName,
    partEName,
    partPrecision,
    rate,
    currencySymbol,
    totCurrencyName,
    totCurrencyEName,
    totPartName,
    totPartEName,
    pricesDigits
  ];
}
