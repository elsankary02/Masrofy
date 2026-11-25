import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

enum ExpenseCategoryType {
  food,
  transportation,
  bills,
  shopping,
  entertainment,
  other,
}

class ExpenseCategoryHelper {
  ExpenseCategoryHelper._();

  static const List<ExpenseCategoryType> orderedTypes = [
    ExpenseCategoryType.food,
    ExpenseCategoryType.transportation,
    ExpenseCategoryType.bills,
    ExpenseCategoryType.shopping,
    ExpenseCategoryType.entertainment,
    ExpenseCategoryType.other,
  ];

  static ExpenseCategoryType resolveType(String? rawKey) {
    final normalized = (rawKey ?? '')
        .trim()
        .toLowerCase()
        .replaceAll('ة', 'ه')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا');

    if (normalized.isEmpty) return ExpenseCategoryType.other;

    if (normalized == LocaleKeys.food.toLowerCase() ||
        normalized.contains('food') ||
        normalized.contains('طعام') ||
        normalized.contains('اكل')) {
      return ExpenseCategoryType.food;
    }

    if (normalized == LocaleKeys.transportation.toLowerCase() ||
        normalized.contains('transport') ||
        normalized.contains('مواصلات')) {
      return ExpenseCategoryType.transportation;
    }

    if (normalized == LocaleKeys.bills.toLowerCase() ||
        normalized.contains('bill') ||
        normalized.contains('فواتير')) {
      return ExpenseCategoryType.bills;
    }

    if (normalized == LocaleKeys.shopping.toLowerCase() ||
        normalized.contains('shop') ||
        normalized.contains('تسوق')) {
      return ExpenseCategoryType.shopping;
    }

    if (normalized == LocaleKeys.entertainment.toLowerCase() ||
        normalized.contains('entertain') ||
        normalized.contains('ترفيه')) {
      return ExpenseCategoryType.entertainment;
    }

    return ExpenseCategoryType.other;
  }

  static String localeKeyFor(ExpenseCategoryType type) {
    switch (type) {
      case ExpenseCategoryType.food:
        return LocaleKeys.food;
      case ExpenseCategoryType.transportation:
        return LocaleKeys.transportation;
      case ExpenseCategoryType.bills:
        return LocaleKeys.bills;
      case ExpenseCategoryType.shopping:
        return LocaleKeys.shopping;
      case ExpenseCategoryType.entertainment:
        return LocaleKeys.entertainment;
      case ExpenseCategoryType.other:
        return LocaleKeys.other;
    }
  }

  static Color colorFor(ExpenseCategoryType type) {
    switch (type) {
      case ExpenseCategoryType.food:
        return AppColors.error;
      case ExpenseCategoryType.transportation:
        return AppColors.blue;
      case ExpenseCategoryType.bills:
        return AppColors.warning;
      case ExpenseCategoryType.shopping:
        return AppColors.purple;
      case ExpenseCategoryType.entertainment:
        return AppColors.orange;
      case ExpenseCategoryType.other:
        return AppColors.grey400;
    }
  }

  static Color colorFromRawKey(String? rawKey) {
    return colorFor(resolveType(rawKey));
  }
}
