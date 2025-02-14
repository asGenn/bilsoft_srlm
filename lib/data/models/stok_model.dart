class StokModel {
  StokModel({
    required this.data,
    required this.totalCount,
    required this.success,
    required this.message,
    required this.code,
  });

  final List<Datum> data;
  final num totalCount;
  final bool success;
  final dynamic message;
  final dynamic code;

  factory StokModel.fromJson(Map<String, dynamic> json) {
    return StokModel(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
        "success": success,
        "message": message,
        "code": code,
      };
}

class Datum {
  Datum({
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
    required this.stokRafi,
    required this.kullaniciAdi,
    required this.subeAdi,
    required this.stokN11Id,
    required this.stokOzelKod1,
    required this.stokOzelKod2,
    required this.stokOzelKod3,
    required this.stokOzelKod4,
    required this.aliciUrunKodu,
    required this.saticiUrunKodu,
    required this.seriNo,
    required this.oivOran,
    required this.oivDahil,
    required this.fatHammaddeIsl,
    required this.fatIsl,
    required this.fatIslEtic,
    required this.hizlisatisbutonayarlari,
    required this.sayim,
    required this.sayimtemple,
    required this.stokEticaret,
    required this.stokfiyatlar,
    required this.stokHammadde,
    required this.stokIsl,
    required this.teklifsiparisIsl,
    required this.tmpFatIsl,
  });

  final num bakiye;
  final num giris;
  final num cikis;
  final int id;
  final String kod;
  final String ad;
  final String grup;
  final num aFiyat;
  final num sFiyat;
  final String kdvOran;
  final String kdvDahil;
  final String otvOran;
  final String otvDahil;
  final String birim;
  final String barkod;
  final String resimYolu;
  final String stokRafi;
  final String kullaniciAdi;
  final String subeAdi;
  final String stokN11Id;
  final String stokOzelKod1;
  final String stokOzelKod2;
  final String stokOzelKod3;
  final String stokOzelKod4;
  final String aliciUrunKodu;
  final String saticiUrunKodu;
  final String seriNo;
  final String oivOran;
  final String oivDahil;
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

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      bakiye: json["bakiye"] ?? 0,
      giris: json["giris"] ?? 0,
      cikis: json["cikis"] ?? 0,
      id: json["id"] ?? 0,
      kod: json["kod"] ?? "",
      ad: json["ad"] ?? "",
      grup: json["grup"] ?? "",
      aFiyat: json["aFiyat"] ?? 0,
      sFiyat: json["sFiyat"] ?? 0,
      kdvOran: json["kdvOran"] ?? "",
      kdvDahil: json["kdvDahil"] ?? "",
      otvOran: json["otvOran"] ?? "",
      otvDahil: json["otvDahil"] ?? "",
      birim: json["birim"] ?? "",
      barkod: json["barkod"] ?? "",
      resimYolu: json["resimYolu"] ?? "",
      stokRafi: json["stokRafi"] ?? "",
      kullaniciAdi: json["kullaniciAdi"] ?? "",
      subeAdi: json["subeAdi"] ?? "",
      stokN11Id: json["stokN11Id"] ?? "",
      stokOzelKod1: json["stokOzelKod1"] ?? "",
      stokOzelKod2: json["stokOzelKod2"] ?? "",
      stokOzelKod3: json["stokOzelKod3"] ?? "",
      stokOzelKod4: json["stokOzelKod4"] ?? "",
      aliciUrunKodu: json["aliciUrunKodu"] ?? "",
      saticiUrunKodu: json["saticiUrunKodu"] ?? "",
      seriNo: json["seriNo"] ?? "",
      oivOran: json["oivOran"] ?? "",
      oivDahil: json["oivDahil"] ?? "",
      fatHammaddeIsl: json["fatHammaddeIsl"] == null
          ? []
          : List<dynamic>.from(json["fatHammaddeIsl"]!.map((x) => x)),
      fatIsl: json["fatIsl"] == null
          ? []
          : List<dynamic>.from(json["fatIsl"]!.map((x) => x)),
      fatIslEtic: json["fatIslEtic"] == null
          ? []
          : List<dynamic>.from(json["fatIslEtic"]!.map((x) => x)),
      hizlisatisbutonayarlari: json["hizlisatisbutonayarlari"] == null
          ? []
          : List<dynamic>.from(json["hizlisatisbutonayarlari"]!.map((x) => x)),
      sayim: json["sayim"],
      sayimtemple: json["sayimtemple"] == null
          ? []
          : List<dynamic>.from(json["sayimtemple"]!.map((x) => x)),
      stokEticaret: json["stokEticaret"] == null
          ? []
          : List<dynamic>.from(json["stokEticaret"]!.map((x) => x)),
      stokfiyatlar: json["stokfiyatlar"] == null
          ? []
          : List<dynamic>.from(json["stokfiyatlar"]!.map((x) => x)),
      stokHammadde: json["stokHammadde"] == null
          ? []
          : List<dynamic>.from(json["stokHammadde"]!.map((x) => x)),
      stokIsl: json["stokIsl"] == null
          ? []
          : List<dynamic>.from(json["stokIsl"]!.map((x) => x)),
      teklifsiparisIsl: json["teklifsiparisIsl"] == null
          ? []
          : List<dynamic>.from(json["teklifsiparisIsl"]!.map((x) => x)),
      tmpFatIsl: json["tmpFatIsl"] == null
          ? []
          : List<dynamic>.from(json["tmpFatIsl"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "bakiye": bakiye,
        "giris": giris,
        "cikis": cikis,
        "id": id,
        "kod": kod,
        "ad": ad,
        "grup": grup,
        "aFiyat": aFiyat,
        "sFiyat": sFiyat,
        "kdvOran": kdvOran,
        "kdvDahil": kdvDahil,
        "otvOran": otvOran,
        "otvDahil": otvDahil,
        "birim": birim,
        "barkod": barkod,
        "resimYolu": resimYolu,
        "stokRafi": stokRafi,
        "kullaniciAdi": kullaniciAdi,
        "subeAdi": subeAdi,
        "stokN11Id": stokN11Id,
        "stokOzelKod1": stokOzelKod1,
        "stokOzelKod2": stokOzelKod2,
        "stokOzelKod3": stokOzelKod3,
        "stokOzelKod4": stokOzelKod4,
        "aliciUrunKodu": aliciUrunKodu,
        "saticiUrunKodu": saticiUrunKodu,
        "seriNo": seriNo,
        "oivOran": oivOran,
        "oivDahil": oivDahil,
        "fatHammaddeIsl": fatHammaddeIsl.map((x) => x).toList(),
        "fatIsl": fatIsl.map((x) => x).toList(),
        "fatIslEtic": fatIslEtic.map((x) => x).toList(),
        "hizlisatisbutonayarlari":
            hizlisatisbutonayarlari.map((x) => x).toList(),
        "sayim": sayim,
        "sayimtemple": sayimtemple.map((x) => x).toList(),
        "stokEticaret": stokEticaret.map((x) => x).toList(),
        "stokfiyatlar": stokfiyatlar.map((x) => x).toList(),
        "stokHammadde": stokHammadde.map((x) => x).toList(),
        "stokIsl": stokIsl.map((x) => x).toList(),
        "teklifsiparisIsl": teklifsiparisIsl.map((x) => x).toList(),
        "tmpFatIsl": tmpFatIsl.map((x) => x).toList(),
      };
}
