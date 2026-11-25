import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/main/tabs/more_tab/presentation/cubits/locale_cubit.dart';
import 'features/main/tabs/more_tab/presentation/cubits/theme_cubit.dart';

class Masrofy extends StatelessWidget {
  const Masrofy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: locale,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: mode,
            );
          },
        );
      },
    );
  }
}
