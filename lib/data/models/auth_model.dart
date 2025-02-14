import 'package:equatable/equatable.dart';

class AuthModel with EquatableMixin {
  final String vergiNumarasi;
  final String kullaniciAdi;
  final String kullaniciSifre;
  final String veritabaniAd;
  final String donemYil;
  final String subeAd;
  final String apiKullaniciAdi;
  final String apiKullaniciSifre;

  AuthModel({
    required this.vergiNumarasi,
    required this.kullaniciAdi,
    required this.kullaniciSifre,
    required this.veritabaniAd,
    required this.donemYil,
    required this.subeAd,
    required this.apiKullaniciAdi,
    required this.apiKullaniciSifre,
  });

  @override
  List<Object?> get props => [
        vergiNumarasi,
        kullaniciAdi,
        kullaniciSifre,
        veritabaniAd,
        donemYil,
        subeAd,
        apiKullaniciAdi,
        apiKullaniciSifre
      ];

  Map<String, dynamic> toJson() {
    return {
      'vergiNumarasi': vergiNumarasi,
      'kullaniciAdi': kullaniciAdi,
      'kullaniciSifre': kullaniciSifre,
      'veritabaniAd': veritabaniAd,
      'donemYil': donemYil,
      'subeAd': subeAd,
      'apiKullaniciAdi': apiKullaniciAdi,
      'apiKullaniciSifre': apiKullaniciSifre,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      vergiNumarasi: json['vergiNumarasi'] as String,
      kullaniciAdi: json['kullaniciAdi'] as String,
      kullaniciSifre: json['kullaniciSifre'] as String,
      veritabaniAd: json['veritabaniAd'] as String,
      donemYil: json['donemYil'] as String,
      subeAd: json['subeAd'] as String,
      apiKullaniciAdi: json['apiKullaniciAdi'] as String,
      apiKullaniciSifre: json['apiKullaniciSifre'] as String,
    );
  }
}
