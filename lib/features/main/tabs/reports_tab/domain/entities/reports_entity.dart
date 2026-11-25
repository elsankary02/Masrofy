import 'package:flutter/material.dart';

class SummaryCardEntity {
  final String label;
  final String amount;
  final String? changeText;
  final Color? changeColor;
  final String subText;
  final bool isPercentage;

  const SummaryCardEntity({
    required this.label,
    required this.amount,
    this.changeText,
    this.changeColor,
    required this.subText,
    this.isPercentage = false,
  });
}

class CategoryBreakdownEntity {
  final String keyName;
  final String label;
  final Color color;
  final double amount;
  final double fraction;

  const CategoryBreakdownEntity({
    required this.keyName,
    required this.label,
    required this.color,
    required this.amount,
    required this.fraction,
  });

  String get percentageText => '${(fraction * 100).round()}%';
  String get formattedAmount => 'EGP ${amount.round()}';
}

class ReportsEntity {
  final String filterKey;
  final List<SummaryCardEntity> summaryCards;
  final List<CategoryBreakdownEntity> categories;
  final int totalExpensesAmount;

  const ReportsEntity({
    required this.filterKey,
    required this.summaryCards,
    required this.categories,
    required this.totalExpensesAmount,
  });
}
