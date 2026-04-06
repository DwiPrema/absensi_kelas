import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/routes/router.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/features/home/ui/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          selectionColor: AppColors.blueCard.withValues(alpha: 0.3),
          selectionHandleColor: AppColors.blueCard,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.generate,
    );
  }
}
