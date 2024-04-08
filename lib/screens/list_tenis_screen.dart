import 'package:flutter/material.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';

class ListTenisScreen extends StatefulWidget {
  const ListTenisScreen({super.key});

  @override
  State<ListTenisScreen> createState() => _ListTenisScreenState();
}

class _ListTenisScreenState extends State<ListTenisScreen> {
  _onNewTenis() {
    GoRouter.of(context).push('/tenis/new');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenis'),
      ),
      drawer: const DrawerWidget(
        currentDestination: DrawerWidgetDestinations.tenis,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewTenis,
        child: const Icon(Icons.add),
      ),
    );

  }
}
