import 'package:flutter_sqlite/screens/home_screen.dart';
import 'package:flutter_sqlite/screens/login_screen.dart';
import 'package:flutter_sqlite/screens/register_screen.dart';
import 'package:flutter_sqlite/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRoutes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: "/home",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/login",
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: "/register",
    builder: (context, state) => const RegisterScreen(),
  )
]);
