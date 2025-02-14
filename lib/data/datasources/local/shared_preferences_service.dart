import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  get _prefs => getIt<SharedPreferences>();
  Future<void> saveRiskLimit(int stokId, int limit) async {
    await _prefs.setInt('risk_limit_$stokId', limit);
  }
  Future<int> getRiskLimit(int stokId) async {
    return _prefs.getInt('risk_limit_$stokId') ?? 0;
  }
}
