import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_theme.dart';

class Masrofy extends StatelessWidget {
  const Masrofy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
