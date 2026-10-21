import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("IncomePage", style: context.textTheme.labelLarge),
      ),
    );
  }
}
