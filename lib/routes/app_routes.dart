import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/models/mutual_fund.dart';

import '../views/screens/screens.dart';

kPrint(Object data) {
  if (kDebugMode) {
    print(data);
  }
}

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),

    GoRoute(
      path: '/schemes',
      builder: (context, state) => const SchemeListScreen(),
    ),

    GoRoute(
      path: '/scheme-details',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        var mf = extras['mf'] as MutualFund;
        return SchemeDetailsScreen(mf: mf);
      },
    ),
  ],
);
