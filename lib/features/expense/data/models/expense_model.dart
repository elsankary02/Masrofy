import 'package:masrofy/features/expense/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  const ExpenseModel({
    required super.id,
    required super.amount,
    required super.categoryKey,
    required super.date,
    super.note = '',
    super.imagePath,
  });

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      amount: entity.amount,
      categoryKey: entity.categoryKey,
      date: entity.date,
      note: entity.note,
      imagePath: entity.imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'categoryKey': categoryKey,
      'date': date.toIso8601String(),
      'note': note,
      'imagePath': imagePath,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id']?.toString() ?? '',
      amount: ((json['amount'] as num?) ?? 0).toDouble(),
      categoryKey: json['categoryKey']?.toString() ?? 'other',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      note: json['note']?.toString() ?? '',
      imagePath: json['imagePath']?.toString(),
    );
  }
}
