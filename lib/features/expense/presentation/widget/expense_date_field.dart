import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'custom_field_tile.dart';

class ExpenseDateField extends StatelessWidget {
  final String date;
  final VoidCallback onTap;

  const ExpenseDateField({super.key, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return CustomFieldTile(
      label: LocaleKeys.date_time.tr(),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 17,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              date,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
