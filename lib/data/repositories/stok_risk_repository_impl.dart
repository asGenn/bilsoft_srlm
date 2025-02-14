import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import '../../domain/repositories/stok_risk_repository.dart';

class StokRiskRepositoryImpl implements StokRiskRepository {
 

  StokRiskRepositoryImpl();

  @override
  Future<int> getRiskLimit(int stokId) async {
    return getIt<SharedPreferencesService>().getRiskLimit(stokId);
  }

  @override
  Future<void> saveRiskLimit(int stokId, int limit) async {
    await getIt<SharedPreferencesService>().saveRiskLimit(stokId, limit);
  }
}
