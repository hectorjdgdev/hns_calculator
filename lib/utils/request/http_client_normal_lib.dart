
import 'dio_factory.dart';
import 'package:dio/dio.dart';

class HttpClientNormalLib {
  static Map<String, String> headers = {
    "X-CoinAPI-Key": ""
  };
  static String baseUrl = "https://rest.coinapi.io";
  static DioFactory dio = DioFactory(headers, baseUrl);

  static Future<Response> doGet(String url, {Map<String, dynamic>? queryParameter}) async {
    var response = await dio.getMethod(
        url,
        queryParameter: queryParameter);
    return response;

  }
}
