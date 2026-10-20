import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/home/presentation/widget/app_bar_home_widget.dart';
import 'package:masrofy/features/home/presentation/widget/summary_card_home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h * .020),
          child: Column(
            children: [
              AppBarHomeWidget(),
              SizedBox(height: context.h * .020),
              SummaryCardHomeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
