import 'package:dio/dio.dart';
import 'package:movie_app/Core/APIs/contants_vars.dart';

class ApiManager{
  late Dio dio;

  ApiManager(){
    dio=Dio(BaseOptions(baseUrl: Constants.ytsBaseUrl));
  }

  Future<Response>getApi(String endPoint,{Map<String,dynamic>? params}){
    return dio.get(endPoint,queryParameters: params);
  }
}