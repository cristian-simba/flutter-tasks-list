import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_final/providers/task_provider.dart';
import 'package:repaso_final/screens/navbar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider())
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navbar()
    );
  }
}
