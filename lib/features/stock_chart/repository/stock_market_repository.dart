// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stock_market/core/constants/apis.dart';
import 'package:stock_market/core/errors/error_handler.dart';
import 'package:stock_market/core/networks/http_service.dart';
import 'package:stock_market/features/stock_chart/models/stock_model.dart';

class StockMarketRepository {
  DioHttpService dio;
  StockMarketRepository({
    required this.dio,
  });
  Future<Either<AppErrorHandler, List<StockModel>>> getStockMarket() async {
    try {
      final response = await dio.handleGetRequest(path: ApiEndPoint.stockUrl);

      if (response.statusCode == 200) {
        return Right(StockModel.fromListMap(response.data));
      } else {
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(AppErrorHandler(message: e.message.toString()));
    }
  }
}
