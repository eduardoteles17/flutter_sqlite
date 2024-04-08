import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:go_router/go_router.dart';

class DrawerWidgetDestinations {
  static const int brands = 0;
  static const int tenis = 1;
  static const int users = 2;
  static const int logout = 3;
}

class DrawerWidget extends StatefulWidget {
  final int currentDestination;

  const DrawerWidget({
    super.key,
    required this.currentDestination,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthController _authController = getIt.get<AuthController>();

  _logout() async {
    await _authController.logout();
    if (!context.mounted) {
      return;
    }

    GoRouter.of(context).go('/login');
  }

  _onSelectDestination(int index) async {
    switch (index) {
      case DrawerWidgetDestinations.brands:
        GoRouter.of(context).go('/brands');
        break;
      case DrawerWidgetDestinations.tenis:
        GoRouter.of(context).go('/tenis');
        break;
      case DrawerWidgetDestinations.users:
        GoRouter.of(context).go('/users');
        break;
      case DrawerWidgetDestinations.logout:
        _logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: widget.currentDestination,
      onDestinationSelected: _onSelectDestination,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Header',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Marcas'),
          icon: Icon(Icons.business_outlined),
          selectedIcon: Icon(Icons.business),
        ),
        const NavigationDrawerDestination(
          label: Text('Tenis'),
          icon: Icon(Icons.category_outlined),
          selectedIcon: Icon(Icons.category),
        ),
        const NavigationDrawerDestination(
          label: Text('Usuários'),
          icon: Icon(Icons.person_outlined),
          selectedIcon: Icon(Icons.person),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.logout_outlined),
          label: Text('Sair'),
        ),
      ],
    );
  }
}
