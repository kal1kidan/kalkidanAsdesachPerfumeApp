import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'kalperfumes',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.initial,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
