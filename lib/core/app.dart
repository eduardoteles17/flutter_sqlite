import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';

abstract class App {
  static Future<bool> init() async {
    await getIt.allReady();

    final authController = getIt.get<AuthController>();
    final isAuthenticated = await authController.init();

    await Future.delayed(const Duration(seconds: 2));

    return isAuthenticated;
  }
}
