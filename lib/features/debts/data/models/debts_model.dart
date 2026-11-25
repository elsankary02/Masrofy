import 'package:flutter/material.dart';

import '../../domain/entities/debt_entity.dart';

class DebtsModel extends DebtEntity {
  const DebtsModel({
    required super.id,
    required super.title,
    super.subtitle = '',
    required super.current,
    required super.target,
    required super.colorValue,
  });

  Color get color => Color(colorValue);

  factory DebtsModel.fromEntity(DebtEntity entity) {
    return DebtsModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      current: entity.current,
      target: entity.target,
      colorValue: entity.colorValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'current': current,
      'target': target,
      'colorValue': colorValue,
    };
  }

  factory DebtsModel.fromJson(Map<String, dynamic> json) {
    return DebtsModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      current: (json['current'] as num?) ?? 0,
      target: (json['target'] as num?) ?? 0,
      colorValue: (json['colorValue'] as int?) ?? 0xFFEF4444,
    );
  }
}
