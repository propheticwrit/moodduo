part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<Category, List<Category>> baseCategories;

  const HomeLoaded({required this.baseCategories});
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
