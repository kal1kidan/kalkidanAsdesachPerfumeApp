import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'presentation/home_screen/home_screen.dart';

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
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.pink,
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
