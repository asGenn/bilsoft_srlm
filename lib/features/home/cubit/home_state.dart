part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<StokEntity> stokList;
  final List<StokEntity> filteredList;

  const HomeLoaded({
    required this.stokList,
    this.filteredList = const [],
  });

  @override
  List<Object> get props => [stokList, filteredList];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
