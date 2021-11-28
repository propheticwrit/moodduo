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

class ConfigurationError extends ConfigurationState {}
