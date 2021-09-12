import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasileirao_app/auth/auth_credentials.dart';
import 'package:brasileirao_app/auth/auth_cubit.dart';
import 'package:brasileirao_app/auth/auth_repository.dart';
import 'package:brasileirao_app/auth/form_submission_status.dart';
import 'package:brasileirao_app/auth/login/login_event.dart';
import 'package:brasileirao_app/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo,required this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.login(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        // authCubit.launchSession(AuthCredentials(
        //   userId: userId,
        //   username: state.username
        // ));
      } catch (e) {
        Exception exception = e as Exception;
        yield state.copyWith(formStatus: SubmissionFailed(exception:exception));
      }
    }
  }
}
