import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ExpensePage", style: context.textTheme.labelLarge),
      ),
    );
  }
}
