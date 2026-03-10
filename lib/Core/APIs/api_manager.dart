import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/APIs/contants_vars.dart';

@LazySingleton()
class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.tmdbBaseUrl,
        queryParameters: {
          "api_key": Constants.apiKey,
        },
      ),
    );
  }

  Future<Response> getApi(String endPoint, {Map<String, dynamic>? params}) {
    return dio.get(endPoint, queryParameters: params);
  }
}
