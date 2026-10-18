import 'package:flutter/material.dart';
import 'package:masroofy/core/theme/app_theme.dart';

class Masroofy extends StatelessWidget {
  const Masroofy({super.key});

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
