import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqlite/controllers/tenis_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/tenis_model.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ListTenisScreen extends StatefulWidget {
  const ListTenisScreen({super.key});

  @override
  State<ListTenisScreen> createState() => _ListTenisScreenState();
}

class _ListTenisScreenState extends State<ListTenisScreen> {
  final TenisController _tenisController = getIt.get<TenisController>();

  _refreshTenis() {
    setState(() {});
  }

  _onNewTenis() async {
    await GoRouter.of(context).push('/tenis/new');
    _refreshTenis();
  }

  _onEditTenis(TenisWithBrand tenis) async {
    await GoRouter.of(context).push(
      '/tenis/edit',
      extra: tenis,
    );
    _refreshTenis();
  }

  _onDeleteTenis(int tenisId) async {
    final response = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text(
            'Deseja realmente excluir este tênis? Excluira todos os dados relacionados a ele. Esta ação não poderá ser desfeita!',
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

    await _tenisController.deleteTenis(tenisId);
    _refreshTenis();
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
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshTenis();
        },
        child: FutureBuilder<List<TenisWithBrand>>(
          future: _tenisController.findAllTenisWithBrand(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro ao carregar os dados: ${snapshot.error}',
                ),
              );
            }

            final tenisList = snapshot.data;

            if (tenisList == null || tenisList.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset("assets/lottie/nenhum-item.json"),
                        const Text('Nenhum tenis cadastrado'),
                      ],
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: tenisList.length,
              itemBuilder: (context, index) {
                final tenis = tenisList[index];

                return Slidable(
                  key: Key(tenis.id.toString()),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => _onDeleteTenis(tenis.id),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(tenis.name),
                    subtitle: Text(tenis.brand.name),
                    trailing: Text(tenis.color),
                    onTap: () => _onEditTenis(tenis),
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
