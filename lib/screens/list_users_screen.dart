import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/controllers/users_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/widgets/drawer_widget.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  final AuthController _authController = getIt.get<AuthController>();
  final UserController _userController = getIt.get<UserController>();

  Future<void> _refreshUsers() async {
    setState(() {});
  }

  Future<void> _deleteUser(int userId) async {
    if (userId == _authController.user.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você não pode excluir seu próprio usuário!'),
        ),
      );
      return;
    }

    final response = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text(
            'Deseja realmente excluir este usuário? Excluira todos os dados relacionados a ele. Esta ação não poderá ser desfeita!',
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

    await _userController.deleteUser(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      drawer: const DrawerWidget(
        currentDestination: DrawerWidgetDestinations.users,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: FutureBuilder(
          future: _userController.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao buscar usuários: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return Slidable(
                    key: ValueKey(user.id),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) => _deleteUser(user.id),
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
