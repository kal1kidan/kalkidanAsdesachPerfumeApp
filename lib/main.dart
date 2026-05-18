import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'presentation/home_screen/home_screen.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'widgets/custom_error_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bool hasShownError = false;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (!hasShownError) {
      hasShownError = true;
      Future.delayed(const Duration(seconds: 5), () {
        hasShownError = false;
      });
      return CustomErrorWidget(errorDetails: details);
    }

    return const SizedBox.shrink();
  };

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
