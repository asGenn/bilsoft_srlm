import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/domain/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.unknown());

  Future<void> checkUserIsLoggedIn() async {
    final isLogin = await getIt<AuthRepository>().checkUserIsLoggedIn();

    isLogin.fold(
      onSuccess: (data) {
        emit(SplashState.authenticated());
      },
      onFailure: (error) {
        emit(SplashState.unauthenticated());
      },
    );
  }
}
