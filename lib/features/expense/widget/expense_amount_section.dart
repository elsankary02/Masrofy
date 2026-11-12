import 'package:flutter/material.dart';
import 'package:masrofy/features/expense/widget/amount_input_field.dart';

class ExpenseAmountSection extends StatelessWidget {
  final TextEditingController controller;

  const ExpenseAmountSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AmountInputField(controller: controller);
  }
}
