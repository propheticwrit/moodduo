part of 'api_cubit.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class APILoginInitial extends ApiState {}

class APILoginInProgress extends ApiState {}

class APILoginSuccessful extends ApiState {
  final String authToken;

  const APILoginSuccessful({required this.authToken});
}

class APILoginFailed extends ApiState {
  final String errMessage;

  const APILoginFailed({required this.errMessage});
}
