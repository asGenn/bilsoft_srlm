import 'package:bilsoft_srlm/data/datasources/local/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final int riskLimit;
  DetailLoaded(this.riskLimit);
}

class DetailError extends DetailState {
  final String message;
  DetailError(this.message);
}

class DetailCubit extends Cubit<DetailState> {
  final SharedPreferencesService _preferencesService;
  final int stokId;

  DetailCubit(this._preferencesService, this.stokId) : super(DetailInitial()) {
    getRiskLimit();
  }

  Future<void> getRiskLimit() async {
    emit(DetailLoading());
    try {
      final limit = await _preferencesService.getRiskLimit(stokId);
      emit(DetailLoaded(limit));
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }

  Future<void> updateRiskLimit(int limit) async {
    emit(DetailLoading());
    try {
      await _preferencesService.saveRiskLimit(stokId, limit);
      emit(DetailLoaded(limit));
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }
}
