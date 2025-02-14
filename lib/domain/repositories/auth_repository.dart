import 'package:bilsoft_srlm/core/result/result.dart';
import 'package:bilsoft_srlm/data/models/auth_model.dart';
import 'package:bilsoft_srlm/data/models/auth_response_model.dart';
enum AuthenticationStatus{
  unknown,
  authenticated,
  unauthenticated
}
abstract class AuthRepository {

  Future<Result<AuthenticationStatus>> checkUserIsLoggedIn();

  Future<Result<AuthResponseModel>> login(AuthModel authModel);


}