import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/tenis_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/tenis_model.dart';
import 'package:flutter_sqlite/utils/autocomplete_brand.dart';
import 'package:go_router/go_router.dart';

class FormData {
  String brandId;
  String name;
  String color;

  FormData({
    this.name = '',
    this.brandId = '',
    this.color = '',
  });
}

class EditTenisScreen extends StatefulWidget {
  final TenisWithBrand tenis;

  const EditTenisScreen({
    super.key,
    required this.tenis,
  });

  @override
  State<EditTenisScreen> createState() => _EditTenisScreenState();
}

class _EditTenisScreenState extends State<EditTenisScreen> {
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
    _tenisController.updateTenis(
      id: widget.tenis.id,
      name: _formData.name,
      brandId: int.parse(_formData.brandId),
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
  void initState() {
    _formData.brandId = widget.tenis.brand.name;
    _formData.name = widget.tenis.name;
    _formData.color = widget.tenis.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tenis.name),
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
                    initialValue: TextEditingValue(
                      text: widget.tenis.brand.name,
                    ),
                    onSelected: (int brandId) {
                      _formData.brandId = brandId.toString();
                    },
                  ),
                ],
              ),
              TextFormField(
                initialValue: widget.tenis.name,
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
                initialValue: widget.tenis.color,
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
