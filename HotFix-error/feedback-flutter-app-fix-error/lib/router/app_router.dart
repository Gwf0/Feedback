import 'package:feedback24_app/password_recovery/recovery.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:feedback24_app/authentication/authentication.dart';

import 'package:feedback24_app/home/home.dart' show HomePage;
import 'package:feedback24_app/sign_in/sign_in.dart' show SignInPage;
import 'package:feedback24_app/sign_up/checkout/checkout.dart'
    show CheckoutPage;
import 'package:feedback24_app/splash/splash.dart' show SplashPage;
import 'package:feedback24_app/audit_details/audit_details.dart'
    show AuditDetailsPage;
import 'package:feedback24_app/personal_editing/view/personal_editing_page.dart'
    show PersonalEditPage;

class AppRouter {
  GoRouter get goRouter => _goRouter;
  final AuthenticationBloc _authBloc;

  AppRouter(AuthenticationBloc bloc) : _authBloc = bloc;

  late final GoRouter _goRouter = GoRouter(
      refreshListenable: GoRouterRefreshStream(_authBloc.stream),
      urlPathStrategy: UrlPathStrategy.path,
      debugLogDiagnostics: false,
      initialLocation: '/splash',
      routes: <GoRoute>[
        GoRoute(
          name: 'root',
          path: '/',
          redirect: (state) =>
              state.namedLocation('home', params: {'tab': 'map'}),
        ),
        GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          name: 'signin',
          path: '/signin',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const SignInPage(),
          ),
        ),
        GoRoute(
          name: 'signup',
          path: '/signup',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const CheckoutPage(),
          ),
        ),
        GoRoute(
          name: 'recovery',
          path: '/recovery',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const RecoveryPage(),
          ),
        ),
        GoRoute(
          name: 'edit',
          path: '/edit',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const PersonalEditPage(),
          ),
        ),
        GoRoute(
          name: 'exit',
          path: '/exit',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: HomePage(tab: ''),
          ),
        ),
        GoRoute(
          name: 'home',
          path: '/home/:tab(map|audit|profile)',
          pageBuilder: (context, state) {
            final tab = state.params['tab']!;
            return MaterialPage<void>(
              key: state.pageKey,
              child: HomePage(tab: tab),
            );
          },
          routes: [
            GoRoute(
              name: 'audit-details',
              path: 'details/:auditId',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: AuditDetailsPage(
                  auditId: state.params['auditId']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'details',
          path: '/details-redirector/:auditId',
          redirect: (state) => state.namedLocation(
            'audit-details',
            params: {'tab': 'audit', 'auditId': state.params['auditId']!},
          ),
        ),
        GoRoute(
          path: '/map',
          redirect: (state) =>
              state.namedLocation('home', params: {'tab': 'map'}),
        ),
        GoRoute(
          path: '/audit',
          redirect: (state) =>
              state.namedLocation('home', params: {'tab': 'audit'}),
        ),
        GoRoute(
          path: '/profile',
          redirect: (state) =>
              state.namedLocation('home', params: {'tab': 'profile'}),
        ),
        GoRoute(
          name: 'payment',
          path: '/profile-payment',
          redirect: (state) => state.namedLocation(
            'profile-payment',
            params: {'tab': 'profile'},
          ),
        ),
      ],
      redirect: (state) {
        final authState = _authBloc.state;

        final rootLoc = state.namedLocation('root');

        final splashLoc = state.namedLocation('splash');
        final plaingSplash = state.subloc == splashLoc;

        final loginLoc = state.namedLocation('signin');
        final loggingIn = state.subloc == loginLoc;

        final createAccountLoc = state.namedLocation('signup');
        final creatingAccount = state.subloc == createAccountLoc;

        final recoveryLoc = state.namedLocation('recovery');
        final recoveryPass = state.subloc == recoveryLoc;

        final unInitialized = authState is UnInitialized;
        final loggedIn = authState is Authenticated;

        if (unInitialized && !plaingSplash) {
          return splashLoc;
        }

        if (!loggedIn &&
            !unInitialized &&
            !loggingIn &&
            !creatingAccount &&
            !recoveryPass) return loginLoc;
        if (loggedIn &&
            (loggingIn || creatingAccount || recoveryPass || plaingSplash))
          return rootLoc;

        return null;
      });
}
