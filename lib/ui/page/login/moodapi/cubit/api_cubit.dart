import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit({required this.authenticationRepository}) : super(APILoginInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> logInWithMoodAPI() async {
    emit(APILoginInProgress());
    try {
      String authToken = await authenticationRepository.logInWithMoodAPI();
      emit(APILoginSuccessful(authToken: authToken));
    } on Exception catch (e) {
      emit(APILoginFailed(errMessage: e.toString()));
    }
  }
}
