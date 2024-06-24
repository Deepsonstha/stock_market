import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stock_market/core/constants/apis.dart';

class DioHttpService {
  Future<Dio> getDioClient() async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        baseUrl: ApiEndPoint.baseUrl,
      ),
    );

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));

    return dio;
  }

  Future<Response> handleGetRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Dio dio = await getDioClient();
    try {
      return await dio.get(
        path,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse ||
          e.type == DioExceptionType.cancel ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        return Response(
          statusMessage: e.message,
          data: e.response?.data,
          requestOptions: RequestOptions(path: path),
          statusCode: e.response?.statusCode,
        );
      }
      return Response(
        statusMessage: e.message,
        data: e.response?.data,
        requestOptions: RequestOptions(path: path),
        statusCode: e.response?.statusCode,
      );
    }
  }
}
