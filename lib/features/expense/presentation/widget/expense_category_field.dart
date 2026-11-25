import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'custom_field_tile.dart';

class ExpenseCategoryField extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const ExpenseCategoryField({
    super.key,
    required this.category,
    required this.onTap,
  });

  ({IconData icon, Color color}) _categoryVisual(String key) {
    final normalized = key.trim().toLowerCase();
    if (normalized.contains('food') || key == LocaleKeys.food) {
      return (icon: Icons.restaurant_rounded, color: AppColors.orange);
    }
    if (normalized.contains('transport') || key == LocaleKeys.transportation) {
      return (icon: Icons.directions_car_rounded, color: AppColors.blue);
    }
    if (normalized.contains('bill') || key == LocaleKeys.bills) {
      return (icon: Icons.receipt_long_rounded, color: AppColors.purple);
    }
    if (normalized.contains('shop') || key == LocaleKeys.shopping) {
      return (icon: Icons.shopping_bag_rounded, color: AppColors.success);
    }
    if (normalized.contains('entertain') || key == LocaleKeys.entertainment) {
      return (icon: Icons.movie_rounded, color: AppColors.expense);
    }
    return (icon: Icons.category_rounded, color: AppColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final visual = _categoryVisual(category);

    return CustomFieldTile(
      label: LocaleKeys.category.tr(),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: visual.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: visual.color.withValues(alpha: 0.28)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(visual.icon, size: 15, color: visual.color),
                const SizedBox(width: 6),
                Text(
                  category.tr(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: visual.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
