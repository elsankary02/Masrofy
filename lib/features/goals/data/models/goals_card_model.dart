import 'package:flutter/material.dart';

class GoalsCardModel {
  final String id;
  final String title;
  final Color color;
  final String iconKey;
  final int current;
  final int target;

  GoalsCardModel({
    required this.id,
    required this.title,
    required num current,
    required num target,
    this.iconKey = 'flag',
    required this.color,
  }) : current = current.toInt(),
       target = target.toInt();

  IconData get icon => iconFromKey(iconKey);

  static IconData iconFromKey(String key) {
    switch (key) {
      case 'shield':
        return Icons.shield_rounded;
      case 'laptop':
        return Icons.laptop_rounded;
      case 'mouse':
        return Icons.mouse_rounded;
      case 'keyboard':
        return Icons.keyboard_rounded;
      case 'savings':
        return Icons.savings_rounded;
      default:
        return Icons.flag_rounded;
    }
  }

  double get progress =>
      target <= 0 ? 0.0 : (current / target).clamp(0.0, 1.0);

  int get percentage => (progress * 100).round();

  bool get isActive => current < target;
  bool get isCompleted => target > 0 && current >= target;

  GoalsCardModel copyWith({
    String? id,
    String? title,
    Color? color,
    String? iconKey,
    num? current,
    num? target,
  }) {
    return GoalsCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      iconKey: iconKey ?? this.iconKey,
      current: current != null ? current.toInt() : this.current,
      target: target != null ? target.toInt() : this.target,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color.toARGB32(),
      'iconKey': iconKey,
      'current': current,
      'target': target,
    };
  }

  factory GoalsCardModel.fromJson(Map<String, dynamic> json) {
    return GoalsCardModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      color: Color((json['color'] as int?) ?? 0xFF7C3AED),
      iconKey: json['iconKey']?.toString() ?? 'flag',
      current: (json['current'] as num?) ?? 0,
      target: (json['target'] as num?) ?? 0,
    );
  }
}
