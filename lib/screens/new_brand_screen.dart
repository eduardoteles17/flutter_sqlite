import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:go_router/go_router.dart';

class FormData {
  String name;

  FormData({
    this.name = '',
  });
}

class NewBrandScreen extends StatefulWidget {
  const NewBrandScreen({super.key});

  @override
  State<NewBrandScreen> createState() => _NewBrandScreenState();
}

class _NewBrandScreenState extends State<NewBrandScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final BrandsController _brandsController = getIt.get<BrandsController>();

  final FormData _formData = FormData();

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    await _brandsController.createBrand(
      name: _formData.name,
    );

    if (!context.mounted) {
      return;
    }

    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Marca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onSaved: (value) => _formData.name = value!,
                onFieldSubmitted: (_) => _onSubmit(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
