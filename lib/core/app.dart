import 'package:flutter_sqlite/core/injector.dart';

abstract class App {
  static Future<void> init() async {
    await getIt.allReady();
    await Future.delayed(const Duration(seconds: 2));
  }
}
