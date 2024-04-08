import 'package:flutter/material.dart';
import 'package:flutter_sqlite/core/injector.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupApp();

  runApp(const App());
}


