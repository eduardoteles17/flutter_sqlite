import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/brand_model.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';

class ListBrandsScreen extends StatefulWidget {
  const ListBrandsScreen({super.key});

  @override
  State<ListBrandsScreen> createState() => _ListBrandsScreenState();
}

class _ListBrandsScreenState extends State<ListBrandsScreen> {
  final BrandsController _brandsController = getIt.get<BrandsController>();

  Future<void> _refreshBrands() async {
    setState(() {});
  }

  _onNewBrand() async {
    await GoRouter.of(context).push('/brands/new');
    _refreshBrands();
  }

  _onEditBrand(Brand brand) async {
    await GoRouter.of(context).push(
      '/brands/edit',
      extra: brand,
    );
    _refreshBrands();
  }

  _onDeleteBrand(int brandId) async {
    final response = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text(
            'Deseja realmente excluir esta marca? Excluira todos os dados relacionados a ela. Esta ação não poderá ser desfeita!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (response != true) {
      return;
    }

    await _brandsController.deleteBrand(brandId);
    _refreshBrands();
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
      body: RefreshIndicator(
        onRefresh: _refreshBrands,
        child: FutureBuilder<List<Brand>>(
          future: _brandsController.findAllBrands(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            }

            final brands = snapshot.data;

            if (brands == null || brands.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: const Center(
                    child: Text('Nenhuma marca cadastrada'),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];

                return Slidable(
                  key: ValueKey(brand.id),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => _onDeleteBrand(brand.id),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(brand.name),
                    onTap: () => _onEditBrand(brand),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
