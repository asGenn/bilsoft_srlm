import 'dart:developer';

import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/result/result.dart';
import 'package:bilsoft_srlm/core/utils/helpers/ensure_valid_token.dart';
import 'package:bilsoft_srlm/data/datasources/network/bilsoft_api.dart';
import 'package:bilsoft_srlm/data/datasources/local/secure_storage_service.dart';
import 'package:bilsoft_srlm/data/models/auth_model.dart';
import 'package:bilsoft_srlm/data/models/auth_response_model.dart';
import 'package:bilsoft_srlm/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Result<AuthResponseModel>> login(AuthModel authModel) {
    return getIt<BilsoftApi>().login(authModel);
  }

  @override
  Future<Result<AuthenticationStatus>> checkUserIsLoggedIn() async {
    final isLogin = await _checkUserToken();
    if (isLogin) {
      return Result.success(AuthenticationStatus.authenticated);
    } else {
      final authModel = await getIt<AuthRepository>().login(
        AuthModel(
            vergiNumarasi: "0123456002",
            kullaniciAdi: "abdulsametgencc@gmail.com",
            kullaniciSifre: "kfgYm3Bd28",
            veritabaniAd: "0123456002",
            donemYil: "2025",
            subeAd: "Merkez",
            apiKullaniciAdi: "BLS-bd82cd11b2a1",
            apiKullaniciSifre: "ec0f9393-0913-4967-aedb-4be70a6e33a1"),
      );
      authModel.fold(
        onSuccess: (response) {
          log("giriş başarılı");
          getIt<SecureStorageService>()
              .write(SecureStorageKey.token, response.data.token);
          return Result.success(AuthenticationStatus.authenticated);
        },
        onFailure: (e) {
          log(e);
          log("Giriş Başarısız");
          return Result.success(AuthenticationStatus.unauthenticated);
        },
      );
    }
    return Result.success(AuthenticationStatus.unauthenticated);
  }
}

Future<bool> _checkUserToken() async {
  final token =
      await getIt<SecureStorageService>().read(SecureStorageKey.token);
  if (token != null && ensureValidToken(token)) {
    return true;
  } else {
    return false;
  }
}

