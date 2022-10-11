import 'package:dio/dio.dart';

class DioHelper {
  // Create Object From Dio
  static late Dio dio;

  // Initial Value For Dio
  static init() {
    dio = Dio(
      // Here Base Url
        BaseOptions(

            // base Url For Shop App
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
            headers: {'Content-Type': 'application/json'}));
  }

  //Function For Get Data
  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,String lang = 'en', String? token
      })
  async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };
    return await dio.get(url, queryParameters: query);
  }



  // Function For Post Data
  static Future<Response> postData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? token,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };

    return await dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }


  // Function For Update User Data
  static Future<Response> putData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? token,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };

    return await dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }
}
