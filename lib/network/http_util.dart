import 'package:dio/dio.dart';
class HttpUtil{
  static Dio _dio;

  static const int CONNECT_TIMEOUT=10000;
  static const int RECEIVE_TIMEOUT=3000;
  static const String BASE_URL="https://www.dytt8.net/";

  static Dio getDioInstance(){
    if(_dio==null){
      var options=BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        responseType: ResponseType.plain,
        baseUrl: BASE_URL
      );
      _dio=Dio(options);
      //dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    return _dio;
  }

  /// request method
  //url 请求链接
  //parameters 请求参数
  //metthod 请求方式
  //onSuccess 成功回调
  //onError 失败回调
  static void request<T>(String url,
     {parameters,
      method,
      Function(T t) onSuccess,
      Function(String error) onError}) async {
    parameters = parameters ?? {};
    method = method ?? 'GET';

    /// 请求处理
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    /// 打印:请求地址-请求方式-请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + parameters.toString());

    Dio dio = getDioInstance();
    //请求结果
    var result;
    try {
      Response response = await dio.request(url,
          data: parameters, options: new Options(method: method));
      result = response.data;
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess(result);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
      onError(e.toString());
    }
  }
}