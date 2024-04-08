import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FormData {
  String email;
  String password;

  FormData({
    this.email = '',
    this.password = '',
  });
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FormData _formData = FormData();

  final AuthController authController = getIt.get<AuthController>();

  _onRegister() {
    GoRouter.of(context).push('/register');
  }

  _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState?.save();

    try {
      await authController.login(
        email: _formData.email,
        password: _formData.password,
      );

      if (!context.mounted) {
        return;
      }

      GoRouter.of(context).go('/home');
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário ou senha inválidos"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/lottie/login.json",
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _formData.email = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email é obrigatório';
                      }
          
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    onSaved: (value) => _formData.password = value!,
                    onFieldSubmitted: (_) => _onSubmit(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      }
          
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  const Text("Não tem uma conta?"),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _onRegister,
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
