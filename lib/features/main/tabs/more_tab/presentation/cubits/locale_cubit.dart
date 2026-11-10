import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/core/utils/constants/app_strings.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(Locale("en")) {
    _localeSaved();
  }
  void _localeSaved() {
    final isSaved = SPService.getString(PrefsKeys.locale);
    switch (isSaved) {
      case 'ar':
        emit(Locale('ar'));
        break;
      case 'en':
        emit(Locale('en'));
        break;
      default:
        emit(Locale('en'));
        break;
    }
  }

  Future<void> changeLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    emit(locale);
    await SPService.setString(PrefsKeys.locale, locale.languageCode);
  }
}

String getLocaleSubTitle(BuildContext context) {
  final locale = context.watch<LocaleCubit>().state;

  switch (locale.languageCode) {
    case 'ar':
      return LocaleKeys.arabic.tr();
    case 'en':
      return LocaleKeys.english.tr();
  }
  return LocaleKeys.english.tr();
}
