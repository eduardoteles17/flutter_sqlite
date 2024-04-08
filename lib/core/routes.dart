import 'package:flutter_sqlite/screens/list_brands_screen.dart';
import 'package:flutter_sqlite/screens/list_tenis_screen.dart';
import 'package:flutter_sqlite/screens/list_users_screen.dart';
import 'package:flutter_sqlite/screens/login_screen.dart';
import 'package:flutter_sqlite/screens/new_brand_screen.dart';
import 'package:flutter_sqlite/screens/new_tenis_screen.dart';
import 'package:flutter_sqlite/screens/register_screen.dart';
import 'package:flutter_sqlite/screens/splash_screen.dart';
import 'package:flutter_sqlite/utils/shared_axis_transition_builder.dart';
import 'package:go_router/go_router.dart';

final appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/home",
      redirect: (_, __) => "/brands",
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: "/brands",
      pageBuilder: sharedAxisTransitionBuilder(const ListBrandsScreen()),
      routes: [
        GoRoute(
          path: "new",
          pageBuilder: sharedAxisTransitionBuilder(const NewBrandScreen()),
        ),
      ],
    ),
    GoRoute(
      path: "/tenis",
      pageBuilder: sharedAxisTransitionBuilder(const ListTenisScreen()),
      routes: [
        GoRoute(
          path: "new",
          pageBuilder: sharedAxisTransitionBuilder(const NewTenisScreen()),
        ),
      ],
    ),
    GoRoute(
      path: "/users",
      pageBuilder: sharedAxisTransitionBuilder(const ListUsersScreen()),
    )
  ],
);
