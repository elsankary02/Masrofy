import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("GoalsPage", style: context.textTheme.labelLarge),
      ),
    );
  }
}
