import '../../utils/request/http_client_lib.dart';
import '../model/conversion_rate.dart';

class ConversionApi {
  static Future<double> getConversionRate(String symbol, String conversion,
      {bool isReversed = false, int pass = 0}) async {
    Map<String, dynamic> queryParameter = {
      "symbol": symbol,
      "convert": conversion
    };
    if (pass > 2) {
      return 0;
    }
    var response = await HttpClientLib.doGet(
        "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest",
        queryParameter);
    var data = response.data["data"][symbol] as List<dynamic>;
    if (data.isNotEmpty) {
      var dataCurrency = data[0] as Map<String, dynamic>;
      var price = ConversionRate.fromJson(dataCurrency, conversion).quote.price;
      print(price);
      return price;
    } else {
      pass += 1;
      var price = 1 /
          await getConversionRate(conversion, symbol,
              isReversed: true, pass: pass);
      print(price);
      return price;
    }
  }
}
