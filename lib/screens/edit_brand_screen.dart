import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/brand_model.dart';
import 'package:go_router/go_router.dart';

class FormData {
  String name;

  FormData({
    this.name = '',
  });
}

class EditBrandScreen extends StatefulWidget {
  final Brand brand;

  const EditBrandScreen({
    super.key,
    required this.brand,
  });

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final BrandsController _brandController = getIt.get<BrandsController>();

  final FormData _formData = FormData();

  _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    await _brandController.updateBrand(
      id: widget.brand.id,
      name: _formData.name,
    );

    if (!context.mounted) {
      return;
    }

    GoRouter.of(context).pop();
  }

  @override
  void initState() {
    _formData.name = widget.brand.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData.name,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onSaved: (value) => _formData.name = value!,
                onFieldSubmitted: (_) => _onSubmit(),
                validator: (value) {
                  if (value!.isEmpty) {
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
