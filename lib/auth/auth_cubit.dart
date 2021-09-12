import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasileirao_app/auth/auth_credentials.dart';
import 'package:brasileirao_app/session_cubit.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit( {required this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
   required  String username,
    String? email,
    String? password,
  }) {
    credentials = AuthCredentials(
      username,
      email,
      password,
      username: username,
    
      
      
    );
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}