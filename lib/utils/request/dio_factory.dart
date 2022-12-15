import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioFactory{
  Dio dio = Dio();
  Options? optionsCache;

  DioFactory(Map<String, String> headers, String baseUrl){
    optionsCache = buildCacheOptions(
      const Duration(days: 1),
      options: Options(headers: headers),
      forceRefresh: false,
      maxStale: const Duration(days: 1),
    );
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl: baseUrl))
        .interceptor);
  }

  getMethod(String url, {Map<String, dynamic>? queryParameter}){
    return  dio.get(
        url,
        queryParameters: queryParameter,
        options: optionsCache);
  }

}