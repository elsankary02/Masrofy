import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/app.dart';
import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/core/utils/constants/app_strings.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/cubits/locale_cubit.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/cubits/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPService.init();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: AppStrings.pathTranslations,
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LocaleCubit()),
        ],
        child: Masrofy(),
      ),
    ),
  );
}
