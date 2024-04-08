import 'package:flutter/material.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';

class ListBrandsScreen extends StatefulWidget {
  const ListBrandsScreen({super.key});

  @override
  State<ListBrandsScreen> createState() => _ListBrandsScreenState();
}

class _ListBrandsScreenState extends State<ListBrandsScreen> {
  _onNewBrand() {
    GoRouter.of(context).push('/brands/new');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcas'),
      ),
      drawer: const DrawerWidget(
        currentDestination: DrawerWidgetDestinations.brands,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewBrand,
        child: const Icon(Icons.add),
      ),
    );
  }
}
