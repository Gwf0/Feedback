import 'package:feedback24_app/personal/personal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:feedback24_app/router/app_router.dart';
import 'package:feedback24_app/style/theme.dart';
import 'package:feedback24_app/authentication/authentication.dart';
import 'package:feedback24_app/profile/profile.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<PersonalRepository>(
          create: (context) => PersonalRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
              )..add(AppStarted()),
            ),
            /*BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context),
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context)),
            ),*/
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(),
            )
          ],
          child: Builder(builder: (context) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            final appRouter = AppRouter(authBloc);

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routeInformationParser: appRouter.goRouter.routeInformationParser,
              routerDelegate: appRouter.goRouter.routerDelegate,
              theme: FeedbackTheme.theme,
            );
          })),
    );
  }
}
