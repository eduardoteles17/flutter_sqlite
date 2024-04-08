import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/users_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FormData {
  String name;
  String email;
  String password;

  FormData({
    this.name = '',
    this.email = '',
    this.password = '',
  });
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FormData _formData = FormData();

  final UserController userController = getIt.get<UserController>();

  _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState?.save();

    try {
      await userController.createUser(
        name: _formData.name,
        email: _formData.email,
        password: _formData.password,
      );

      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário criado com sucesso"),
        ),
      );

      GoRouter.of(context).pop();
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email já cadastrado"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Lottie.asset(
                  "assets/lottie/register.json",
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => _formData.name = value!,
                  // onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome é obrigatório';
                    }
        
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData.email = value!,
                  // onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email é obrigatório';
                    }
        
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  onSaved: (value) => _formData.password = value!,
                  onFieldSubmitted: (_) => _onSubmit(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Senha é obrigatória';
                    }
        
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
