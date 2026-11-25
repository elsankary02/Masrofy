import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../domain/entities/transaction_entity.dart';
import '../cubit/transactions_cubit.dart';
import '../cubit/transactions_state.dart';
import 'transaction_item_widget.dart';

class TransactionItemBuilder extends StatelessWidget {
  const TransactionItemBuilder({super.key});

  String _formatDateLabel(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return LocaleKeys.today.tr();
    if (target == yesterday) return LocaleKeys.yesterday.tr();
    return DateFormat('yyyy/MM/dd', context.locale.languageCode).format(target);
  }

  List<GroupedTransactionsEntity> _groupByDate(
    BuildContext context,
    List<TransactionEntity> items,
  ) {
    final Map<String, List<TransactionEntity>> map = {};
    for (final item in items) {
      final label = _formatDateLabel(context, item.date);
      map.putIfAbsent(label, () => []).add(item);
    }
    return map.entries
        .map((e) => GroupedTransactionsEntity(dateLabel: e.key, items: e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.h30),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final grouped = _groupByDate(context, state.filteredTransactions);
        if (grouped.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.h30),
            child: Center(
              child: Text(
                LocaleKeys.no_transactions.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: grouped.length,
          itemBuilder: (context, dayIndex) {
            final dayGroup = grouped[dayIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Text(
                    dayGroup.dateLabel,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(context.h15),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? AppColors.cardDark
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.isDarkMode
                          ? AppColors.borderDark
                          : AppColors.grey200,
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
                    itemCount: dayGroup.items.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 0.5,
                      color: context.isDarkMode
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                    ),
                    itemBuilder: (context, itemIndex) {
                      return TransactionItemWidget(
                        transaction: dayGroup.items[itemIndex],
                      );
                    },
                  ),
                ),
                SizedBox(height: context.h20),
              ],
            );
          },
        );
      },
    );
  }
}
