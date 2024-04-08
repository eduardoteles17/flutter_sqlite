import 'package:flutter_sqlite/models/brand_model.dart';
import 'package:flutter_sqlite/models/tenis_model.dart';
import 'package:flutter_sqlite/screens/edit_brand_screen.dart';
import 'package:flutter_sqlite/screens/edit_tenis_screen.dart';
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
      redirect: (_, __) => "/tenis",
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
      pageBuilder: sharedAxisTransitionBuilder(
          (context, state) => const ListBrandsScreen()),
      routes: [
        GoRoute(
          path: "new",
          pageBuilder: sharedAxisTransitionBuilder(
              (context, state) => const NewBrandScreen()),
        ),
        GoRoute(
          path: "edit",
          pageBuilder: sharedAxisTransitionBuilder(
            (context, state) => EditBrandScreen(
              brand: state.extra as Brand,
            ),
          ),
        )
      ],
    ),
    GoRoute(
      path: "/tenis",
      pageBuilder: sharedAxisTransitionBuilder(
          (context, state) => const ListTenisScreen()),
      routes: [
        GoRoute(
          path: "new",
          pageBuilder: sharedAxisTransitionBuilder(
              (context, state) => const NewTenisScreen()),
        ),
        GoRoute(
          path: "edit",
          pageBuilder: sharedAxisTransitionBuilder(
            (context, state) => EditTenisScreen(
              tenis: state.extra as TenisWithBrand,
            ),
          ),
        )
      ],
    ),
    GoRoute(
      path: "/users",
      pageBuilder: sharedAxisTransitionBuilder(
          (context, state) => const ListUsersScreen()),
    )
  ],
);
