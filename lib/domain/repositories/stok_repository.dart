import 'package:bilsoft_srlm/core/result/result.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';

abstract class StokRepository {
  Future<Result<List<StokEntity>>> getStokList();
}
