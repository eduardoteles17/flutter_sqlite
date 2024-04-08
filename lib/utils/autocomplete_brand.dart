import 'package:flutter/material.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';

class AutoCompleteBrand extends StatefulWidget {
  final TextEditingValue? initialValue;
  final void Function(int brandId) onSelected;

  const AutoCompleteBrand({
    super.key,
    this.initialValue,
    required this.onSelected,
  });

  @override
  State<AutoCompleteBrand> createState() => _AutoCompleteBrandState();
}

class _AutoCompleteBrandState extends State<AutoCompleteBrand> {
  final BrandsController _brandsController = BrandsController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: widget.initialValue,
      onSelected: (String value) async {
        final brand = await _brandsController.findBrandByName(value);
        widget.onSelected(brand!.id);
      },
      optionsBuilder: (textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable.empty();
        }

        final brands = await _brandsController.findManyBrandsByName(
          textEditingValue.text,
        );

        return brands.map((e) => e.name).toList();
      },
    );
  }
}
