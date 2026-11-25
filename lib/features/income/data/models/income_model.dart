import 'package:flutter/material.dart';
import 'package:masrofy/features/income/domain/entities/income_entity.dart';

class IncomeModel extends IncomeEntity {
  const IncomeModel({
    required super.id,
    required super.title,
    super.subtitle = '',
    super.frequency = '',
    required super.amount,
    super.iconKey = 'trending_up',
    required super.iconColorValue,
  });

  Color get iconColor => Color(iconColorValue);

  IconData get icon => iconFromKey(iconKey);

  static IconData iconFromKey(String key) {
    switch (key) {
      case 'payments':
        return Icons.payments_rounded;
      case 'work':
        return Icons.work_rounded;
      case 'savings':
        return Icons.savings_rounded;
      case 'account_balance':
        return Icons.account_balance_rounded;
      default:
        return Icons.trending_up_rounded;
    }
  }

  factory IncomeModel.fromEntity(IncomeEntity entity) {
    return IncomeModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      frequency: entity.frequency,
      amount: entity.amount,
      iconKey: entity.iconKey,
      iconColorValue: entity.iconColorValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'frequency': frequency,
      'amount': amount,
      'iconKey': iconKey,
      'iconColorValue': iconColorValue,
    };
  }

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      frequency: json['frequency']?.toString() ?? '',
      amount: ((json['amount'] as num?) ?? 0).toInt(),
      iconKey: json['iconKey']?.toString() ?? 'trending_up',
      iconColorValue: (json['iconColorValue'] as int?) ?? 0xFF16A34A,
    );
  }
}
