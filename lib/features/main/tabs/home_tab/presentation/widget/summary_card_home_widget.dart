import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/app_images.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/cubit/home_cubit.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/cubit/home_state.dart';

class SummaryCardHomeWidget extends StatelessWidget {
  const SummaryCardHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0');

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final balanceText = state.isObscured
            ? '******'
            : formatter.format(state.summary.totalBalance);
        final incomeText = state.isObscured
            ? '******'
            : formatter.format(state.summary.totalIncome);
        final expenseText = state.isObscured
            ? '******'
            : formatter.format(state.summary.totalExpenses);

        return Container(
          padding: EdgeInsets.all(context.h20),
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
              Row(
                spacing: 8,
                children: [
                  InkWell(
                    onTap: () =>
                        context.read<HomeCubit>().toggleBalanceVisibility(),
                    child: Icon(
                      state.isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                  Text(
                    LocaleKeys.financial_summary.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.h5),
              _TotalBalanceAndImage(balanceText: balanceText),
              SizedBox(height: context.h5),
              Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.white.withValues(alpha: 0.3),
              ),
              SizedBox(height: context.h15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CardSubTitle(
                    title: LocaleKeys.total_income.tr(),
                    price: incomeText,
                    color: AppColors.primaryLight,
                  ),
                  Container(
                    width: 0.5,
                    height: context.h35,
                    color: AppColors.white.withValues(alpha: 0.3),
                  ),
                  _CardSubTitle(
                    title: LocaleKeys.total_expenses.tr(),
                    price: expenseText,
                    color: AppColors.debt,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TotalBalanceAndImage extends StatelessWidget {
  final String balanceText;
  const _TotalBalanceAndImage({required this.balanceText});

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
                color: AppColors.white.withValues(alpha: 0.85),
              ),
            ),
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  balanceText,
                  style: context.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  LocaleKeys.currency_egp.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(
          AppImages.summery,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

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
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
        Row(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              price,
              style: context.textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              LocaleKeys.currency_egp.tr(),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
