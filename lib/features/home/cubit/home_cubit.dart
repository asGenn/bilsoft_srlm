import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:bilsoft_srlm/domain/repositories/stok_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

enum SearchType { ad, grup }

class HomeCubit extends Cubit<HomeState> {
  final _sharedPrefs = getIt<SharedPreferencesService>();

  HomeCubit() : super(HomeInitial());

  void getStokList() async {
    emit(HomeLoading());

    final result = await getIt<StokRepository>().getStokList();

    result.fold(
      onSuccess: (data) async {
        // Load risk limits for each stock
        final List<StokEntity> updatedList = [];
        for (var stok in data) {
          final riskLimit = await _sharedPrefs.getRiskLimit(stok.id);
          updatedList.add(stok.changeRiskLimit(riskLimit));
        }

        emit(HomeLoaded(stokList: updatedList, filteredList: updatedList));
      },
      onFailure: (error) {
        emit(HomeError(message: error));
      },
    );
  }

  void searchStok(String value, SearchType searchType) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final filteredList = currentState.stokList.where((stok) {
        switch (searchType) {
          case SearchType.ad:
            return stok.ad.toLowerCase().contains(value.toLowerCase());
          case SearchType.grup:
            return stok.grup.toLowerCase().contains(value.toLowerCase());
        }
      }).toList();

      emit(HomeLoaded(
        stokList: currentState.stokList,
        filteredList: filteredList,
      ));
    }
  }
}
