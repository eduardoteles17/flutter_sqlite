import 'package:flutter/material.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      drawer: const DrawerWidget(
        currentDestination: DrawerWidgetDestinations.users,
      ),
    );
  }
}
