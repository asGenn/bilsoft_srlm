part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<StokEntity> stokList;
  final List<StokEntity> filteredList;
  final bool isMonitoring;
  final SearchType searchType;
  final StokFilter stokFilter;

  const HomeLoaded({
    required this.stokList,
    required this.filteredList,
    this.isMonitoring = false,
    this.searchType = SearchType.ad,
    this.stokFilter = StokFilter.tumStoklar,
  });

  @override
  List<Object?> get props =>
      [stokList, filteredList, isMonitoring, searchType, stokFilter];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
