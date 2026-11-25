import 'package:flutter/material.dart';

enum TransactionKind { expense, income }

enum TransactionDateFilter { all, today, week, month }

class TransactionEntity {
  final String id;
  final String title;
  final String subtitle;
  final num amount;
  final DateTime date;
  final TransactionKind kind;
  final IconData icon;
  final Color iconColor;
  final String? categoryKey;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.kind,
    required this.icon,
    required this.iconColor,
    this.categoryKey,
  });

  bool get isExpense => kind == TransactionKind.expense;
}

class GroupedTransactionsEntity {
  final String dateLabel;
  final List<TransactionEntity> items;

  const GroupedTransactionsEntity({
    required this.dateLabel,
    required this.items,
  });
}
