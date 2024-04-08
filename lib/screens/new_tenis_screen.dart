import 'package:flutter/material.dart';

class NewTenisScreen extends StatefulWidget {
  const NewTenisScreen({super.key});

  @override
  State<NewTenisScreen> createState() => _NewTenisScreenState();
}

class _NewTenisScreenState extends State<NewTenisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Tênis'),
      ),
      body: const Center(
        child: Text('Novo Tênis'),
      ),
    );
  }
}
