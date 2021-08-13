import 'package:dio/dio.dart';
import 'result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response res, ResponseInterceptorHandler handler) {
    RequestOptions option = res.requestOptions;
    // print("---------response.data----------");
    // print(response.data);
    // print("---------response.data end----------");
    String? type = option.contentType;
    try {
      if (type != null && type.contains("text")) {
        res.data = ResultData(res.data, true, 200);
        handler.next(res);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (res.statusCode == 200 || res.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段

        int code = res.data["code"];
        if (code == 200) {
          res.data = ResultData(res.data, true, 200,
              headers: res.headers);
          handler.next(res);

          // print("----------response.data----------");
          // print(response.data);
          // print("----------response.data end----------");

          return;
        } else {
          res.data = ResultData(res.data, false, 200,
              headers: res.headers);
          handler.next(res);
          return;
        }
      }
    } catch (e) {
      print("ResponseError====" + e.toString() + "****" + option.path);
      res.data = ResultData(res.data, false, res.statusCode,
          headers: res.headers);
      handler.next(res);
      return;
    }

    res.data =
        ResultData(res.data, false, res.statusCode, headers: res.headers);
    handler.next(res);
  }
}
