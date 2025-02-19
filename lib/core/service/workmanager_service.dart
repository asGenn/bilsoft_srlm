import 'dart:developer';

import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/service/notification_service.dart';
import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/domain/repositories/stok_repository.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Arka plan izolesinde de DI yapılandırmasını yapıyoruz.
  await setup().then((_) {
    try {
      Workmanager().executeTask((taskName, inputData) async {
        if (inputData != null && inputData.containsKey("secureStok")) {
          final List<dynamic> secureStok = inputData["secureStok"];
          for (var stokId in secureStok) {
            int id;
            if (stokId is int) {
              id = stokId;
            } else if (stokId is String) {
              id =
                  int.tryParse(stokId) ?? 0; // Dönüşüm başarısız olursa 0 atar.
            } else {
              log("Beklenmeyen tip: ${stokId.runtimeType}");
              continue; // Bilinmeyen tipteki öğeleri atla.
            }

            final riskLimit =
                await getIt<SharedPreferencesService>().getRiskLimit(id);
            log("Stok ID: $id, Risk Limit: $riskLimit");
            final _ = await getIt<StokRepository>().getStokList().then((value) {
              
              value.fold(onSuccess: (data) {
                final stok = data.firstWhere((element) => element.id == id);
                if (stok.giris - stok.cikis < riskLimit) {
                  NotificationService().showNotification(
                      title: "Risk Limit Uyarısı",
                      body: "${stok.ad} için risk limiti aşıldı: ${stok.riskLimit}");
                }
                
              }, onFailure: (error) {
                log("Error: $error");
              });
            });
          }
        }

        return Future.value(true);
      });
    } catch (e) {
      log("Error: $e");
    }
  });
}
