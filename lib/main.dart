import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/features/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.setup();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}