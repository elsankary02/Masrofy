import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/widgets/custom_over_view.dart';
import '../../data/model/over_view_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class OverViewHomeWidget extends StatelessWidget {
  const OverViewHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0');

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final overviewList = getOverviewData(
          context,
          todayExpenses: formatter.format(state.summary.todayExpenses),
          currentMonthIncome: formatter.format(
            state.summary.currentMonthIncome,
          ),
          totalDebts: formatter.format(state.summary.remainingDebts),
          completedGoals:
              '${state.summary.completedGoalsCount} / ${state.summary.totalGoalsCount}',
        );

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColors.cardDark : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.isDarkMode
                  ? AppColors.borderDark
                  : AppColors.borderLight,
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
              color: context.isDarkMode
                  ? AppColors.dividerDark
                  : AppColors.borderLight,
            ),
          ),
        );
      },
    );
  }
}
