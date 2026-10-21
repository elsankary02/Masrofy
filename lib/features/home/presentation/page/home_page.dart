import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/home/presentation/widget/app_bar_home_widget.dart';
import 'package:masrofy/features/home/presentation/widget/over_view__home_widget.dart';
import 'package:masrofy/features/home/presentation/widget/quik_tools_home_widget.dart';
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
              SizedBox(height: context.h * .030),
              _CustomHeader(title: LocaleKeys.quick_tools.tr()),
              SizedBox(height: context.h * .020),
              QuikToolsHomeWidget(),
              SizedBox(height: context.h * .030),
              _CustomHeader(title: LocaleKeys.overview.tr()),
              SizedBox(height: context.h * .020),
              OverViewHomeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  final String title;
  const _CustomHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
