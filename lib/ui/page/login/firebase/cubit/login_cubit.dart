import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/data/model/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationRepository}) : super(LoginInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(LoginInProgress());
    try {
      await authenticationRepository.logInWithGoogle();
      emit(LoginSuccessful(currentUser: authenticationRepository.currentUser));
    } on LogInWithGoogleFailure catch (e) {
      emit(LoginFailed(errMessage: e.message));
    } on Exception catch (e) {
      print(e.toString());
      emit(LoginFailed(errMessage: 'Unknown Error'));
    }
  }

  Future<void> logInWithMoodAPI() async {
    emit(LoginInProgress());
    try {
      await authenticationRepository.logInWithGoogle();
      emit(LoginSuccessful(currentUser: authenticationRepository.currentUser));
    } on Exception catch (e) {
      print(e.toString());
      emit(LoginFailed(errMessage: 'Unknown Error'));
    }
  }
}
