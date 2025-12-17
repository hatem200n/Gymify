import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الصفحة الرئيسية')),
      body: const Center(
        child: Text('باهي، توّا وصلنا للـ Home Page!'),
      ),
    );
  }
}