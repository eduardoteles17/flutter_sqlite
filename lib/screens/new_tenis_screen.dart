import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/tenis_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/utils/autocomplete_brand.dart';
import 'package:go_router/go_router.dart';

class FormData {
  int brandId;
  String name;
  String color;

  FormData({
    this.name = '',
    this.brandId = 0,
    this.color = '',
  });
}

class NewTenisScreen extends StatefulWidget {
  const NewTenisScreen({super.key});

  @override
  State<NewTenisScreen> createState() => _NewTenisScreenState();
}

class _NewTenisScreenState extends State<NewTenisScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TenisController _tenisController = getIt.get<TenisController>();

  final FormData _formData = FormData();

  _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_formData.brandId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma marca'),
        ),
      );
    }

    // Save the tenis
    _tenisController.createTenis(
      name: _formData.name,
      brandId: _formData.brandId,
      color: _formData.color,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tênis salvo com sucesso'),
      ),
    );

    GoRouter.of(context).pop();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Tênis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Marca"),
                  AutoCompleteBrand(
                    onSelected: (int brandId) {
                      _formData.brandId = brandId;
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onSaved: (String? value) {
                  _formData.name = value!;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cor',
                ),
                onSaved: (String? value) {
                  _formData.color = value!;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed:_onSubmit,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
