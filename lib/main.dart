import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'core/theme/app_theme.dart';
import 'core/registry/fluxy_registry.dart';
import 'features/home/home.routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize Framework & Stability Policy
  // strictMode: true throws errors on layout violations (perfect for Dev)
  // strictMode: false (Relaxed) auto-fixes violations (perfect for Prod)
  await Fluxy.init(strictMode: false);

  // 2. Boot Modular Plugins (Auto-generated registry)
  registerFluxyPlugins();
  Fluxy.autoRegister();

  // 3. Setup Global Error Pipeline
  Fluxy.onError((error, stack) {
    debugPrint("Fluxy Global Error: $error");
  });

  // Load saved theme securely from FluxyVault
  final isDarkString = await FluxyVault.read('isDark');
  final isDarkSaved = isDarkString == 'true';

  runApp(
    Fluxy.debug(
      child: FluxyApp(
        title: 'Fluxy App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: isDarkSaved ? ThemeMode.dark : ThemeMode.light,
        initialRoute: homeRoutes.first.path,
        routes: homeRoutes,
      ),
    ),
  );
}
