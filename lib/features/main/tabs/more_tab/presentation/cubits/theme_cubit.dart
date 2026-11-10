import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/core/utils/constants/app_strings.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _themeSaved();
  }

  void _themeSaved() {
    final isSaved = SPService.getString(PrefsKeys.themeMode);

    switch (isSaved) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
        break;
    }
  }

  Future<void> changeTheme(ThemeMode mode) async {
    emit(mode);
    await SPService.setString(PrefsKeys.themeMode, mode.name);
  }
}

String getThemeSubTitle(BuildContext context) {
  final themeMode = context.watch<ThemeCubit>().state;

  switch (themeMode) {
    case ThemeMode.light:
      return LocaleKeys.light_theme.tr();
    case ThemeMode.dark:
      return LocaleKeys.dark_theme.tr();
    case ThemeMode.system:
      return LocaleKeys.system_theme.tr();
  }
}
