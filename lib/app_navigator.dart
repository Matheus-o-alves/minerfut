import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasileirao_app/auth/auth_cubit.dart';
import 'package:brasileirao_app/auth/auth_navigator.dart';
import 'package:brasileirao_app/loading_view.dart';
import 'package:brasileirao_app/session_cubit.dart';
import 'package:brasileirao_app/session_state.dart';
import 'package:brasileirao_app/session_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated) MaterialPage(child: SessionView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
