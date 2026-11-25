class DebtEntity {
  final String id;
  final String title;
  final String subtitle;
  final num current;
  final num target;
  final int colorValue;

  const DebtEntity({
    required this.id,
    required this.title,
    this.subtitle = '',
    required this.current,
    required this.target,
    required this.colorValue,
  });

  bool get isActive => current > 0;
  bool get isPaid => current <= 0;

  num get paidAmount => (target - current).clamp(0, target);

  DebtEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    num? current,
    num? target,
    int? colorValue,
  }) {
    return DebtEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      current: current ?? this.current,
      target: target ?? this.target,
      colorValue: colorValue ?? this.colorValue,
    );
  }
}
