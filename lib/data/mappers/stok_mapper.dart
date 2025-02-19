import 'package:bilsoft_srlm/data/models/stok_model.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';

// Mapper Extension
extension StokModelMapper on StokModel {
  List<StokEntity> toEntities() {
    return data.map((datum) => datum.toEntity()).toList();
  }
}

extension DatumMapper on Datum {
  StokEntity toEntity() {
    return StokEntity(
        bakiye: bakiye.toInt(),
        giris: giris.toInt(),
        cikis: cikis.toInt(),
        id: id,
        kod: kod,
        ad: ad,
        grup: grup,
        aFiyat: aFiyat.toDouble(),
        sFiyat: sFiyat.toDouble(),
        kdvOran: kdvOran,
        kdvDahil: kdvDahil,
        otvOran: otvOran,
        otvDahil: otvDahil,
        birim: birim,
        barkod: barkod,
        resimYolu: resimYolu,
        kullaniciAdi: kullaniciAdi,
        subeAdi: subeAdi,
        stokN11Id: stokN11Id,
        fatHammaddeIsl: fatHammaddeIsl,
        fatIsl: fatIsl,
        fatIslEtic: fatIslEtic,
        hizlisatisbutonayarlari: hizlisatisbutonayarlari,
        sayimtemple: sayimtemple,
        stokEticaret: stokEticaret,
        stokfiyatlar: stokfiyatlar,
        stokHammadde: stokHammadde,
        stokIsl: stokIsl,
        teklifsiparisIsl: teklifsiparisIsl,
        tmpFatIsl: tmpFatIsl);
  }
  
  
}
