import 'package:dio/dio.dart';
import 'code.dart';
import 'dio_log_interceptor.dart';
import 'loading_utils.dart';
import 'response_interceptor.dart';
import 'result_data.dart';
import 'address.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio? _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;
  static const CONNECT_TIMEOUT = 15000;
  static const RECEIVE_TIMEOUT = 15000;

  /// 自定义Header
  Map<String, dynamic> httpHeaders = {

  };

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String? baseUrl}) {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        baseUrl: Address.BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        headers: httpHeaders,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
      ));
      // _dio?.interceptors.add(DioLogInterceptor());
      _dio?.interceptors.add(ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl = ""}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio?.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio?.options.baseUrl != Address.BASE_URL) {
        _dio?.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, {params, withLoading = true}) async {
    if (withLoading) {
      LoadingUtils.show();
    }

    Response? res;
    final Options options = Options(method: "get", headers: httpHeaders);
    try {
      res = await _dio?.get(api, queryParameters: params, options: options);
      print('response:${res}');
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      return resultError(e);
    }

    if (res?.data is DioError) {
      return resultError(res?.data['code']);
    }

    return res?.data;

    // try {
    //   response = await _dio.get(api, queryParameters: params);
    //   print('response:${response}');
    //   if (withLoading) {
    //     LoadingUtils.dismiss();
    //   }
    // } on DioError catch (e) {
    //   if (withLoading) {
    //     LoadingUtils.dismiss();
    //   }
    //   return resultError(e);
    // }
    //
    // if (response.data is DioError) {
    //   return resultError(response.data['code']);
    // }
    //
    // return response.data;
  }

  ///通用的POST请求
  post(api, {params, withLoading = true}) async {
    if (withLoading) {
      LoadingUtils.show();
    }

    Response? res;

    try {
      res = await _dio?.post(api, data: params);
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      return resultError(e);
    }

    if (res?.data is DioError) {
      return resultError(res?.data['code']);
    }

    return res?.data;
  }
}

ResultData resultError(DioError e) {
  Response? errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  }
  // else {
  //   errorResponse = Response(requestOptions: e.response.request, statusCode: 666);
  // }
  if (e.type == HttpManager.CONNECT_TIMEOUT ||
      e.type == HttpManager.RECEIVE_TIMEOUT) {
    errorResponse?.statusCode = Code.NETWORK_TIMEOUT;
  }
  return ResultData(
      errorResponse?.statusMessage, false, errorResponse?.statusCode);
}
