import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v(
        "Requisição para ${data.baseUrl}\nCabeçalhos: ${data.headers}\n"
            "Corpo:${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
          "Requisição para ${data.url}\nStatus da Resposta:${data.statusCode}\n"
              "Cabeçalhos:${data.headers}\nCorpo: ${data.body}");
    } else {
      logger.e(
          "Requisição para ${data.url}\nStatus da Resposta:${data.statusCode}\n"
              "Cabeçalhos:${data.headers}\nCorpo: ${data.body}");
    }
    return data;
  }
}
