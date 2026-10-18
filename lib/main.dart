import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masroofy/app.dart';
import 'package:masroofy/core/utils/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: AppStrings.pathTranslations,
      fallbackLocale: Locale('ar'),
      child: Masroofy(),
    ),
  );
}
