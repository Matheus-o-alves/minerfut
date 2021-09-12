import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasileirao_app/auth/auth_cubit.dart';
import 'package:brasileirao_app/auth/auth_repository.dart';
import 'package:brasileirao_app/auth/form_submission_status.dart';
import 'package:brasileirao_app/auth/sign_up/sign_up_event.dart';
import 'package:brasileirao_app/auth/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo,required  this.authCubit}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Email updated
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmSignUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
                Exception exception = e as Exception;

        yield state.copyWith(formStatus: SubmissionFailed(exception:exception));
      }
    }
  }
}
