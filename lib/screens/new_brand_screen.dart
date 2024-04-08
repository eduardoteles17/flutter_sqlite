import 'package:flutter/material.dart';

class NewBrandScreen extends StatefulWidget {
  const NewBrandScreen({super.key});

  @override
  State<NewBrandScreen> createState() => _NewBrandScreenState();
}

class _NewBrandScreenState extends State<NewBrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Marca'),
      ),
      body: const Center(
        child: Text('Nova Marca'),
      ),
    );
  }
}
