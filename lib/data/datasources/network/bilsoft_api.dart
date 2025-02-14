import 'dart:developer';

import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/result/result.dart';
import 'package:bilsoft_srlm/data/datasources/local/secure_storage_service.dart';
import 'package:bilsoft_srlm/data/mappers/stok_mapper.dart';
import 'package:bilsoft_srlm/data/models/auth_model.dart';
import 'package:bilsoft_srlm/data/models/auth_response_model.dart';
import 'package:bilsoft_srlm/data/models/stok_model.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:dio/dio.dart';

abstract class BilsoftApi {
  Future<Result<List<StokEntity>>> getStokList();
  Future<Result<AuthResponseModel>> login(AuthModel authModel);
}

class BilsoftApiImpl implements BilsoftApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://apiv3.bilsoft.com',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  @override
  Future<Result<List<StokEntity>>> getStokList() async {
    try {
      final token =
          await getIt<SecureStorageService>().read(SecureStorageKey.token);
      _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.post(
        '/api/Stok/GetListWithBakiye',
      );
      final stokResponse = StokModel.fromJson( response.data);
      final stokList = stokResponse.toEntities();
      
      
      

      return Result.success(stokList);
    } catch (e) {
      if (e is DioException) {
        log("DioException: ${e.response?.data}");
        log("Status code: ${e.response?.statusCode}");
        log("Request data: ${e.requestOptions.data}");
        log("Request headers: ${e.requestOptions.headers}");
      } else {
        log("Hata: $e");
      }
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<AuthResponseModel>> login(AuthModel authModel) async {
    try {
      final response = await _dio.post(
        '/api/Auth/GirisYap',
        data: authModel.toJson(),
      );

      final authResponseModel = AuthResponseModel.fromJson(response.data);

      return Result.success(authResponseModel);
    } catch (e) {
      return Future.value(Result.failure(e.toString()));
    }
  }
}
