import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/features/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.setup();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.blueCard,
          selectionColor: AppColors.blueCard.withOpacity(0.3),
          selectionHandleColor: AppColors.blueCard,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
