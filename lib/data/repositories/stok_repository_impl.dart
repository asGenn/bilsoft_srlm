import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/result/result.dart';
import 'package:bilsoft_srlm/data/datasources/network/bilsoft_api.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:bilsoft_srlm/domain/repositories/stok_repository.dart';

class StokRepositoryImpl implements StokRepository {
  @override
  Future<Result<List<StokEntity>>> getStokList() {
    return getIt<BilsoftApi>().getStokList();
  }
}
