import 'package:flutter/material.dart';

enum ExchangeCurrencyType { HNS, BTC, USD, EUR, GBP }

class ExchangeInfo {
  final String icon;
  final String symbolCalculator;
  final String exchangeName;
  final String exchangeSymbol;

  const ExchangeInfo(
      {required this.icon,
        required this.symbolCalculator,
      required this.exchangeName,
      required this.exchangeSymbol});
}

class ExchangeCurrency {
  List<Widget> arrayOfExchanges= [];
  static final Map<ExchangeCurrencyType, ExchangeInfo> mapSymbols =
      <ExchangeCurrencyType, ExchangeInfo>{
    ExchangeCurrencyType.HNS: const ExchangeInfo(
      icon: 'assets/icons/hns_icon_light.svg',
      symbolCalculator: 'assets/icons/hsn_money.svg',
      exchangeName: 'Handshake',
      exchangeSymbol: 'HNS',
    ),
    ExchangeCurrencyType.BTC: const ExchangeInfo(
      icon: 'assets/icons/btc_icon_light.svg',
      symbolCalculator: 'assets/icons/btc_money.svg',
      exchangeName: 'Bitcoin',
      exchangeSymbol: 'BTC',
    ),
    ExchangeCurrencyType.USD: const ExchangeInfo(
        icon: 'assets/icons/usd_icon_light.svg',
        symbolCalculator: 'assets/icons/usd_money.svg',
        exchangeName: 'US Dollar',
        exchangeSymbol: 'USD'),
    ExchangeCurrencyType.EUR: const ExchangeInfo(
      icon: 'assets/icons/eur_icon_light.svg',
      symbolCalculator: 'assets/icons/eur_money.svg',
      exchangeName: 'Euro',
      exchangeSymbol: 'EUR',
    ),
    ExchangeCurrencyType.GBP: const ExchangeInfo(
        icon: 'assets/icons/gbp_icon_light.svg',
        symbolCalculator: 'assets/icons/gbp_money.svg',
        exchangeName: 'British Pound Sterling',
        exchangeSymbol: 'GBP')
  };


  static ExchangeInfo getExchangeInfoFromID(ExchangeCurrencyType id){
    return mapSymbols[id] ?? mapSymbols[ExchangeCurrencyType.HNS]!;
  }
}
