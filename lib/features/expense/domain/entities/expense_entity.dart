class ExpenseEntity {
  final String id;
  final double amount;
  final String categoryKey;
  final DateTime date;
  final String note;
  final String? imagePath;

  const ExpenseEntity({
    required this.id,
    required this.amount,
    required this.categoryKey,
    required this.date,
    this.note = '',
    this.imagePath,
  });

  ExpenseEntity copyWith({
    String? id,
    double? amount,
    String? categoryKey,
    DateTime? date,
    String? note,
    String? imagePath,
    bool clearImage = false,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryKey: categoryKey ?? this.categoryKey,
      date: date ?? this.date,
      note: note ?? this.note,
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
    );
  }
}
