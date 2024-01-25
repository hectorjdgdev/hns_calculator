
import 'dio_factory.dart';
import 'package:dio/dio.dart';

class HttpClientLCryptoLib {
  static Map<String, String> headers = {
    "X-CMC_PRO_API_KEY": ""
  };
  static String baseUrl = "https://pro-api.coinmarketcap.com";
  static DioFactory dio = DioFactory(headers, baseUrl);

  static Future<Response> doGet(String url, {Map<String, dynamic>?  queryParameter}) async {
    var response = await dio.getMethod(
        url,
        queryParameter: queryParameter);
    return response;

  }
}
