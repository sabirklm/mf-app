import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/bloc/auth_bloc.dart';
import 'package:mf_ip/models/mutual_fund.dart';

import '../views/screens/screens.dart';

void kPrint(Object? data) {
  if (kDebugMode) {
    print(data);
  }
}

final GoRouter routerConfig = GoRouter(
  initialLocation: '/auth',
  redirect: (context, state) {
    final authStatus = context.read<AuthBloc>().state.status;

    final isLoggedIn = authStatus == AuthStatus.authenticated;

    final isGoingToLogin = state.matchedLocation == "/auth";

    if (!isLoggedIn && !isGoingToLogin) {
      return "/auth";
    }

    if (isLoggedIn && isGoingToLogin) {
      return "/schemes";
    }

    return null;
  },
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => const LoginScreen()),

    GoRoute(
      path: '/schemes',
      builder: (context, state) => const SchemeListScreen(),
    ),

    GoRoute(
      path: '/scheme-details',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;

        final mf = extras?['mf'] as MutualFund?;

        if (mf == null) {
          return const LoginScreen();
        }

        return SchemeDetailsScreen(mf: mf);
      },
    ),
  ],
);
