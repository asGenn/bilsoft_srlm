import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/data/datasources/network/bilsoft_api.dart';
import 'package:bilsoft_srlm/data/datasources/local/secure_storage_service.dart';
import 'package:bilsoft_srlm/data/repositories/auth_repository_impl.dart';

import 'package:bilsoft_srlm/data/repositories/stok_repository_impl.dart';
import 'package:bilsoft_srlm/data/repositories/stok_risk_repository_impl.dart';
import 'package:bilsoft_srlm/domain/repositories/auth_repository.dart';

import 'package:bilsoft_srlm/domain/repositories/stok_repository.dart';
import 'package:bilsoft_srlm/domain/repositories/stok_risk_repository.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {

  // BilsoftApi
  getIt.registerSingleton<BilsoftApi>(BilsoftApiImpl());
  // Repository
  getIt.registerSingleton<StokRepository>(StokRepositoryImpl());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<StokRiskRepository>(StokRiskRepositoryImpl());
  
  

  // Service
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesService());


  // DataSource
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);


}