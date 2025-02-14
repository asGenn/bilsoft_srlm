class StokEntity {
  final int bakiye;
  final int giris;
  final int cikis;
  final int id;
  final String kod;
  final String ad;
  final String grup;
  final double aFiyat;
  final double sFiyat;
  final String kdvOran;
  final String kdvDahil;
  final String otvOran;
  final String otvDahil;
  final String birim;
  final String barkod;
  final String resimYolu;
  final dynamic stokRafi;
  final String kullaniciAdi;
  final String subeAdi;
  final String stokN11Id;
  final dynamic stokOzelKod1;
  final dynamic stokOzelKod2;
  final dynamic stokOzelKod3;
  final dynamic stokOzelKod4;
  final dynamic aliciUrunKodu;
  final dynamic saticiUrunKodu;
  final dynamic seriNo;
  final dynamic oivOran;
  final dynamic oivDahil;
  final List<dynamic> fatHammaddeIsl;
  final List<dynamic> fatIsl;
  final List<dynamic> fatIslEtic;
  final List<dynamic> hizlisatisbutonayarlari;
  final dynamic sayim;
  final List<dynamic> sayimtemple;
  final List<dynamic> stokEticaret;
  final List<dynamic> stokfiyatlar;
  final List<dynamic> stokHammadde;
  final List<dynamic> stokIsl;
  final List<dynamic> teklifsiparisIsl;
  final List<dynamic> tmpFatIsl;
  final int? riskLimit;

  const StokEntity({
    this.riskLimit = 0,
    required this.bakiye,
    required this.giris,
    required this.cikis,
    required this.id,
    required this.kod,
    required this.ad,
    required this.grup,
    required this.aFiyat,
    required this.sFiyat,
    required this.kdvOran,
    required this.kdvDahil,
    required this.otvOran,
    required this.otvDahil,
    required this.birim,
    required this.barkod,
    required this.resimYolu,
    this.stokRafi,
    required this.kullaniciAdi,
    required this.subeAdi,
    required this.stokN11Id,
    this.stokOzelKod1,
    this.stokOzelKod2,
    this.stokOzelKod3,
    this.stokOzelKod4,
    this.aliciUrunKodu,
    this.saticiUrunKodu,
    this.seriNo,
    this.oivOran,
    this.oivDahil,
    required this.fatHammaddeIsl,
    required this.fatIsl,
    required this.fatIslEtic,
    required this.hizlisatisbutonayarlari,
    this.sayim,
    required this.sayimtemple,
    required this.stokEticaret,
    required this.stokfiyatlar,
    required this.stokHammadde,
    required this.stokIsl,
    required this.teklifsiparisIsl,
    required this.tmpFatIsl,
  });
  StokEntity changeRiskLimit(int riskLimit) {
    return StokEntity(
        riskLimit: riskLimit,
        bakiye: bakiye,
        giris: giris,
        cikis: cikis,
        id: id,
        kod: kod,
        ad: ad,
        grup: grup,
        aFiyat: aFiyat,
        sFiyat: sFiyat,
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
