import 'package:flutter/material.dart';
import 'package:masrofy/core/components/custom_over_view.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/home/data/model/over_view_model.dart';

class OverViewHomeWidget extends StatelessWidget {
  const OverViewHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final overviewList = getOverviewData(
      context,
      todayExpenses: '460',
      currentMonthIncome: '8,250',
      totalDebts: '5,200',
      completedGoals: '2 / 5',
    );
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.isDarkMode ? AppColors.borderDark : AppColors.grey200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: overviewList.length,
        itemBuilder: (context, index) {
          final overView = overviewList[index];
          return CustomOverView(
            color: overView.color,
            icon: overView.icon,
            title: overView.title,
            price: overView.price,
            currency: overView.currency,
            valueColor: overView.valueColor,
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          color: context.isDarkMode ? AppColors.dividerDark : AppColors.grey200,
        ),
      ),
    );
  }
}
