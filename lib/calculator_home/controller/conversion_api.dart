import 'package:hns_calculator/utils/request/http_client_normal_lib.dart';

import '../../utils/request/http_client_crypto_lib.dart';
import '../model/conversion_rate.dart';
import '../model/exchange_currency.dart';

class ConversionApi {
  static Future<double> getConversionRate(ExchangeCurrencyType symbol,
      ExchangeCurrencyType conversion) {
    if ((symbol == ExchangeCurrencyType.EUR ||
        symbol == ExchangeCurrencyType.GBP ||
        symbol == ExchangeCurrencyType.USD) &&
        (conversion == ExchangeCurrencyType.EUR ||
            conversion == ExchangeCurrencyType.GBP ||
            conversion == ExchangeCurrencyType.USD)) {
      return getConversionRateNormal(symbol.name, conversion.name);
    } else {
      return getConversionRateCrypto(symbol.name, conversion.name);
    }
  }

  static Future<double> getConversionRateNormal(String symbol,
      String conversion) async {
    try {
      var response = await HttpClientNormalLib.doGet(
          "https://rest.coinapi.io/v1/exchangerate/$symbol/$conversion");
      return response.data["rate"];
    }
    catch (e) {
      return 0;
    }
  }

  static Future<double> getConversionRateCrypto(String symbol,
      String conversion,
      {bool isReversed = false, int pass = 0}) async {
    Map<String, dynamic> queryParameter = {
      "symbol": symbol,
      "convert": conversion
    };
    if (pass > 2) {
      return 0;
    }
    var response = await HttpClientLCryptoLib.doGet(
        "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest",
        queryParameter: queryParameter);
    var data = response.data["data"][symbol] as List<dynamic>;
    if (data.isNotEmpty) {
      var dataCurrency = data[0] as Map<String, dynamic>;
      var price = ConversionRate
          .fromJson(dataCurrency, conversion)
          .quote
          .price;
      print(price);
      return price;
    } else {
      pass += 1;
      var price = 1 /
          await getConversionRateCrypto(conversion, symbol,
              isReversed: true, pass: pass);
      print(price);
      return price;
    }
  }


}
