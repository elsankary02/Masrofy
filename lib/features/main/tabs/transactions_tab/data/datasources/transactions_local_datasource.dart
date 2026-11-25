import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/services/shared_preferences.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../domain/entities/transaction_entity.dart';

abstract class TransactionsLocalDataSource {
  Future<List<TransactionEntity>> getTransactions();
}

class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  static const String _expensesKey = 'masrofy_expenses_list';
  static const String _incomesKey = 'masrofy_incomes_list';

  num _parseNum(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.tryParse(value.trim()) ?? 0;
    return 0;
  }

  DateTime _parseDate(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  String _normalizeCategoryKey(dynamic raw) {
    final value = (raw ?? '')
        .toString()
        .trim()
        .toLowerCase()
        .replaceAll('ة', 'ه')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا');

    if (value.isEmpty || value == '-') return 'other';
    if (value == 'food' ||
        value.contains('food') ||
        value.contains('طعام') ||
        value.contains('اكل')) {
      return 'food';
    }
    if (value == 'transportation' ||
        value.contains('transport') ||
        value.contains('مواصلات')) {
      return 'transportation';
    }
    if (value == 'bills' ||
        value.contains('bill') ||
        value.contains('فواتير')) {
      return 'bills';
    }
    if (value == 'shopping' ||
        value.contains('shop') ||
        value.contains('تسوق')) {
      return 'shopping';
    }
    if (value == 'entertainment' ||
        value.contains('entertain') ||
        value.contains('ترفيه')) {
      return 'entertainment';
    }
    return 'other';
  }

  List _readList(String key, String nestedKey) {
    final raw = SPService.getString(key);
    if (raw == null || raw.trim().isEmpty) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded
          .whereType()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    if (decoded is Map && decoded[nestedKey] is List) {
      return (decoded[nestedKey] as List)
          .whereType()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return const [];
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final List<TransactionEntity> result = [];

    final expenseMaps = _readList(_expensesKey, 'expenses');
    for (var i = 0; i < expenseMaps.length; i++) {
      final map = expenseMaps[i];
      final amount = _parseNum(map['amount']);
      if (amount <= 0) continue;

      final rawCategory =
          map['category'] ?? map['categoryKey'] ?? map['title'] ?? 'other';
      final normalizedKey = _normalizeCategoryKey(rawCategory);
      final rawTitle = (map['title'] ?? '').toString().trim();
      final resolvedTitle = (rawTitle.isNotEmpty && rawTitle != '-')
          ? rawTitle
          : normalizedKey.tr();

      final subtitle = (map['note'] ?? map['subtitle'] ?? '').toString().trim();

      result.add(
        TransactionEntity(
          id: (map['id'] ?? 'exp_$i').toString(),
          title: resolvedTitle,
          subtitle: subtitle == '-' ? '' : subtitle,
          amount: amount,
          date: _parseDate(map['date'] ?? map['createdAt']),
          kind: TransactionKind.expense,
          icon: Icons.arrow_upward_rounded,
          iconColor: AppColors.expense,
          categoryKey: normalizedKey,
        ),
      );
    }

    final incomeMaps = _readList(_incomesKey, 'incomes');
    for (var i = 0; i < incomeMaps.length; i++) {
      final map = incomeMaps[i];
      final amount = _parseNum(map['amount']);
      if (amount <= 0) continue;

      final title = (map['title'] ?? map['source'] ?? map['category'] ?? '')
          .toString()
          .trim();
      final subtitle = (map['note'] ?? map['subtitle'] ?? map['source'] ?? '')
          .toString()
          .trim();

      result.add(
        TransactionEntity(
          id: (map['id'] ?? 'inc_$i').toString(),
          title: title.isEmpty ? '-' : title,
          subtitle: subtitle,
          amount: amount,
          date: _parseDate(map['date'] ?? map['createdAt']),
          kind: TransactionKind.income,
          icon: Icons.arrow_downward_rounded,
          iconColor: AppColors.success,
        ),
      );
    }

    result.sort((a, b) => b.date.compareTo(a.date));
    return result;
  }
}
