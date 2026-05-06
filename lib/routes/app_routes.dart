import 'package:go_router/go_router.dart';

import '../views/screens/screens.dart';

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
        // final extras = state.extra;
        return SchemeDetailsScreen();
      },
    ),
  ],
);
