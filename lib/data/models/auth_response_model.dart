import 'package:equatable/equatable.dart';

class AuthResponseModel with EquatableMixin {
  final Data data;
  final int totalCount;
  final bool success;
  final Null message;
  final Null code;

  AuthResponseModel({
    required this.data,
    required this.totalCount,
    required this.success,
    required this.message,
    required this.code,
  });

  @override
  List<Object?> get props => [data, totalCount, success, message, code];

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'totalCount': totalCount,
      'success': success,
      'message': message,
      'code': code,
    };
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      totalCount: json['totalCount'] as int,
      success: json['success'] as bool,
      message: json['message'] as Null,
      code: json['code'] as Null,
    );
  }
}

class Data with EquatableMixin {
  final String token;
  final String expiration;
  final String subeAd;
  final String donemYil;

  Data({
    required this.token,
    required this.expiration,
    required this.subeAd,
    required this.donemYil,
  });

  @override
  List<Object?> get props => [token, expiration, subeAd, donemYil];

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
      'subeAd': subeAd,
      'donemYil': donemYil,
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] as String,
      expiration: json['expiration'] as String,
      subeAd: json['subeAd'] as String,
      donemYil: json['donemYil'] as String,
    );
  }
}
