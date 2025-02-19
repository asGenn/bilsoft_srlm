import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:bilsoft_srlm/domain/entities/stok.dart';
import 'package:bilsoft_srlm/domain/repositories/stok_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workmanager/workmanager.dart';

part 'home_state.dart';

enum SearchType { ad, grup }

enum StokFilter {
  tumStoklar,
  stoktaOlanlar,
  riskteOlanlar,
}

class HomeCubit extends Cubit<HomeState> {
  final _sharedPrefs = getIt<SharedPreferencesService>();
  SearchType _searchType = SearchType.ad;
  StokFilter _stokFilter = StokFilter.tumStoklar;
  bool isMonitoring = false;

  HomeCubit() : super(HomeInitial());

  SearchType get currentSearchType => _searchType;
  StokFilter get currentStokFilter => _stokFilter;

  void updateSearchType(SearchType newType) {
    _searchType = newType;
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        stokList: currentState.stokList,
        filteredList: currentState.filteredList,
        isMonitoring: currentState.isMonitoring,
        searchType: newType,
        stokFilter: _stokFilter,
      ));
    }
  }

  void updateStokFilter(StokFilter newFilter) {
    _stokFilter = newFilter;
    filterStoklar(newFilter);
  }

  Future<List<StokEntity>> getStokList() async {
    emit(HomeLoading());

    final result = await getIt<StokRepository>().getStokList();
    final List<StokEntity> updatedList = [];

    result.fold(
      onSuccess: (data) async {
        for (var stok in data) {
          final riskLimit = await _sharedPrefs.getRiskLimit(stok.id);
          updatedList.add(stok.changeRiskLimit(riskLimit));
        }

        emit(HomeLoaded(
          stokList: updatedList,
          filteredList: updatedList,
          isMonitoring: isMonitoring,
          searchType: _searchType,
          stokFilter: _stokFilter,
        ));
      },
      onFailure: (error) {
        emit(HomeError(message: error));
      },
    );
    return updatedList;
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
        isMonitoring: currentState.isMonitoring,
        searchType: searchType,
        stokFilter: _stokFilter,
      ));
    }
  }

  void filterStoklar(StokFilter filter) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final filteredList = currentState.stokList.where((stok) {
        final int kalan = stok.giris - stok.cikis;

        switch (filter) {
          case StokFilter.tumStoklar:
            return true;
          case StokFilter.stoktaOlanlar:
            return kalan > 0;
          case StokFilter.riskteOlanlar:
            return kalan <= (stok.riskLimit ?? 0);
        }
      }).toList();

      emit(HomeLoaded(
        stokList: currentState.stokList,
        filteredList: filteredList,
        isMonitoring: currentState.isMonitoring,
        searchType: _searchType,
        stokFilter: filter,
      ));
    }
  }

  List<StokEntity> getSecureStocks() {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      return currentState.stokList.where((stok) {
        final int kalan = stok.giris - stok.cikis;
        return kalan > (stok.riskLimit ?? 0); // Yeşil olan (güvenli) stoklar
      }).toList();
    }
    return [];
  }

  List<StokEntity> getRiskyStocks() {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      return currentState.stokList.where((stok) {
        final int kalan = stok.giris - stok.cikis;
        return kalan <= (stok.riskLimit ?? 0); // Kırmızı olan (riskli) stoklar
      }).toList();
    }
    return [];
  }

  void startMonitoring() {
    if (state is HomeLoaded) {
      isMonitoring = true;
      final currentState = state as HomeLoaded;

      Workmanager().registerOneOffTask("stokMonitoring", "stokMonitoringTask",
          inputData: {
            "secureStok": getSecureStocks()
                .map<int>(
                  (e) => e.id,
                )
                .toList(),
          });

      emit(HomeLoaded(
        stokList: currentState.stokList,
        filteredList: currentState.filteredList,
        isMonitoring: true,
      ));
    }
  }

  void stopMonitoring() {
    if (state is HomeLoaded) {
      isMonitoring = false;
      final currentState = state as HomeLoaded;
      Workmanager().cancelAll();
      emit(HomeLoaded(
        stokList: currentState.stokList,
        filteredList: currentState.filteredList,
        isMonitoring: false,
      ));
    }
  }
}
