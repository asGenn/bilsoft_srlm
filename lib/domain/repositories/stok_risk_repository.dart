abstract class StokRiskRepository {
  Future<int> getRiskLimit(int stokId);
  Future<void> saveRiskLimit(int stokId, int limit);
}
