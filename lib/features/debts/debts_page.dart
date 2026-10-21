import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("DebtsPage", style: context.textTheme.labelLarge),
      ),
    );
  }
}
