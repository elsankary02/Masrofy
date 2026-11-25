class IncomeEntity {
  final String id;
  final String title;
  final String subtitle;
  final String frequency;
  final int amount;
  final String iconKey;
  final int iconColorValue;

  const IncomeEntity({
    required this.id,
    required this.title,
    this.subtitle = '',
    this.frequency = '',
    required this.amount,
    this.iconKey = 'trending_up',
    required this.iconColorValue,
  });

  IncomeEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? frequency,
    int? amount,
    String? iconKey,
    int? iconColorValue,
  }) {
    return IncomeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      frequency: frequency ?? this.frequency,
      amount: amount ?? this.amount,
      iconKey: iconKey ?? this.iconKey,
      iconColorValue: iconColorValue ?? this.iconColorValue,
    );
  }
}
