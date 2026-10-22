import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/app_images.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/cubit/balance_cubit.dart';

class SummaryCardHomeWidget extends StatelessWidget {
  const SummaryCardHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BalanceCubit(),
      child: Container(
        padding: EdgeInsets.all(context.h * .020),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: AppColors.walletGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row: Toggle Icon and Financial Summary Label
            Row(
              spacing: 8,
              children: [
                BlocBuilder<BalanceCubit, bool>(
                  builder: (context, isObscured) {
                    return InkWell(
                      onTap: () {
                        context.read<BalanceCubit>().toggleBalanceVisibility();
                      },
                      child: Icon(
                        isObscured == true
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
                Text(
                  LocaleKeys.financial_summary.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.70),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.h * .005),
            BlocBuilder<BalanceCubit, bool>(
              builder: (context, isObscured) {
                return _TotalBalanceAndImage(isObscured: isObscured);
              },
            ),
            SizedBox(height: context.h * .005),

            // Horizontal Divider
            Container(
              width: double.infinity,
              height: 0.5,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.3),
              ),
            ),
            SizedBox(height: context.h * 0.016),

            // Footer Row: Total Income and Total Expenses
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CardSubTitle(
                  title: LocaleKeys.total_income.tr(),
                  price: "27,850",
                  color: AppColors.primaryLight,
                ),
                Container(
                  width: 0.5,
                  height: 35,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                _CardSubTitle(
                  title: LocaleKeys.total_expenses.tr(),
                  price: "15,400",
                  color: AppColors.debt,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Local Widgets
// =============================================================================

/// Displays total balance alongside the wallet graphic.
class _TotalBalanceAndImage extends StatelessWidget {
  final bool isObscured;
  const _TotalBalanceAndImage({required this.isObscured});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.total_balance.tr(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.70),
              ),
            ),
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  isObscured == true ? "******" : "12,450",
                  style: context.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  LocaleKeys.currency_pounds.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(
          AppImages.income,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

/// A sub-card component used for displaying financial metrics like income or expenses.
class _CardSubTitle extends StatelessWidget {
  final String title;
  final String price;
  final Color color;
  const _CardSubTitle({
    required this.title,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.white.withValues(alpha: 0.70),
          ),
        ),
        Row(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              price,
              style: context.textTheme.titleMedium?.copyWith(color: color),
            ),
            Text(
              LocaleKeys.currency_pounds.tr(),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.white.withValues(alpha: .70),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
