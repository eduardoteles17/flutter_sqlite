import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = getIt.get();

  int _counter = 0;

  void _logout() async {
    await authController.logout();
    if (!context.mounted) {
      return;
    }
    GoRouter.of(context).go('/login');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      // drawer: const DrawerWidget(
      //   currentDestination: DrawerWidgetDestinations.home,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
