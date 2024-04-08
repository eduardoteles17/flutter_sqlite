import 'package:flutter/material.dart';
import 'package:flutter_sqlite/core/app.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    App.init().then((isAuthenticated) {
      if (isAuthenticated) {
        GoRouter.of(context).go("/home");
      } else {
        GoRouter.of(context).go("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/tenis.json',
          repeat: false,
        ),
      ),
    );
  }
}
