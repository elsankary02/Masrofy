import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/app.dart';
import 'package:masrofy/core/utils/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: AppStrings.pathTranslations,
          fallbackLocale: Locale('ar'),
          child: Masrofy(),
        );
      },
    ),
  );
}
