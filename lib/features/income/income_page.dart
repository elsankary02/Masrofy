import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_appbar.dart';
import 'package:masrofy/features/income/widget/income_bottom_sheet_widget.dart';
import 'package:masrofy/features/income/widget/income_item_widget.dart';
import 'package:masrofy/features/income/widget/income_summary_card_widget.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              CustomAppBar(
                title: LocaleKeys.income_sources.tr(),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      IncomeBottomSheetWidget(isEditing: false),
                ),
              ),
              SizedBox(height: context.h20),
              IncomeSummaryCardWidget(),
              SizedBox(height: context.h30),
              IncomeItemWidget(
                title: "استثمار",
                subtitle: "أرباح الاستثمار",
                frequency: "كل 3 أشهر",
                amount: "2.850",
                icon: Icons.trending_up_rounded,
                iconColor: AppColors.accent,
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      IncomeBottomSheetWidget(isEditing: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
