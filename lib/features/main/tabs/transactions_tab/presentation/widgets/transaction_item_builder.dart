import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/models/transactions_models.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/presentation/widgets/transaction_item_widget.dart';

class TransactionItemBuilder extends StatelessWidget {
  const TransactionItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactionsList.length,
      itemBuilder: (context, dayIndex) {
        final dayGroup = transactionsList[dayIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                dayGroup.date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            // Transaction Item Widget
            Container(
              padding: EdgeInsets.all(16),
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
                  final trans = dayGroup.items[itemIndex];
                  return TransactionItemWidget(
                    title: trans.title,
                    subtitle: trans.subtitle,
                    time: trans.time,
                    amount: trans.amount,
                    icon: trans.icon,
                    iconColor: trans.iconColor,
                    isHighlighted: trans.isHighlighted ?? false,
                  );
                },
              ),
            ),
            SizedBox(height: context.h20),
          ],
        );
      },
    );
  }
}
