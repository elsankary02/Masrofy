import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/services/shared_preferences.dart';
import 'core/utils/constants/app_strings.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/main/tabs/more_tab/presentation/cubits/locale_cubit.dart';
import 'features/main/tabs/more_tab/presentation/cubits/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPService.init();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final authCubit = AuthCubit(AuthRepositoryImpl(AuthLocalDataSourceImpl()))
    ..checkSession();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppStrings.pathTranslations,
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LocaleCubit()),
          BlocProvider.value(value: authCubit),
        ],
        child: const Masrofy(),
      ),
    ),
  );
}
