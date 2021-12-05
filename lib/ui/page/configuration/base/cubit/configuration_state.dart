part of 'configuration_cubit.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoaded extends ConfigurationState {
  final Map<Category, List<Category>> baseCategories;

  const ConfigurationLoaded({required this.baseCategories});
}

class ConfigurationError extends ConfigurationState {
  final String message;

  const ConfigurationError({required this.message});
}

class CategoryDeleted extends ConfigurationState {
  final bool deleted;

  const CategoryDeleted({required this.deleted});
}

class CategoryDeleteError extends ConfigurationState {
  final String message;

  const CategoryDeleteError({required this.message});
}

class CategoryAdded extends ConfigurationState {
  final Category category;

  const CategoryAdded({required this.category});
}

class CategoryAddError extends ConfigurationState {
  final String message;

  const CategoryAddError({required this.message});
}
