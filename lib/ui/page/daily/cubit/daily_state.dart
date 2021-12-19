part of 'daily_cubit.dart';

abstract class DailyState extends Equatable {
  const DailyState();

  @override
  List<Object> get props => [];
}

class DailyInitial extends DailyState {}

class DailyError extends DailyState {
  final String message;

  const DailyError({required this.message});
}
