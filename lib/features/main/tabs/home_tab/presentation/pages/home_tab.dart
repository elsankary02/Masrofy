import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/app_bar_home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/over_view__home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/quik_tools_home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/summary_card_home_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              AppBarHomeWidget(),
              SizedBox(height: context.h20),
              SummaryCardHomeWidget(),
              SizedBox(height: context.h30),
              _CustomHeader(title: LocaleKeys.quick_tools.tr()),
              SizedBox(height: context.h20),
              QuikToolsHomeWidget(),
              SizedBox(height: context.h30),
              _CustomHeader(title: LocaleKeys.overview.tr()),
              SizedBox(height: context.h20),
              OverViewHomeWidget(),
              SizedBox(height: context.h30),
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
