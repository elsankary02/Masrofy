import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

enum DateFilter { thisWeek, thisMonth, lastMonth, thisYear }

extension DateFilterExtension on DateFilter {
  String get label {
    switch (this) {
      case DateFilter.thisWeek:
        return LocaleKeys.this_week.tr();
      case DateFilter.thisMonth:
        return LocaleKeys.this_month.tr();
      case DateFilter.lastMonth:
        return LocaleKeys.last_month.tr();
      case DateFilter.thisYear:
        return LocaleKeys.this_year.tr();
    }
  }
}

class DashboardDateFilterDropdown extends StatefulWidget {
  final ValueChanged<DateFilter>? onFilterChanged;
  const DashboardDateFilterDropdown({super.key, this.onFilterChanged});

  @override
  State<DashboardDateFilterDropdown> createState() =>
      _DashboardDateFilterDropdownState();
}

class _DashboardDateFilterDropdownState
    extends State<DashboardDateFilterDropdown> {
  DateFilter selectedFilter = DateFilter.thisMonth;
  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: PopupMenuButton<DateFilter>(
        color: context.isDarkMode ? AppColors.cardDark : AppColors.white,
        offset: const Offset(0, 45),
        initialValue: selectedFilter,
        onSelected: (DateFilter filter) {
          setState(() {
            selectedFilter = filter;
          });
          widget.onFilterChanged?.call(filter);
        },
        itemBuilder: (context) => DateFilter.values.map((DateFilter filter) {
          return PopupMenuItem<DateFilter>(
            value: filter,
            child: Text(filter.label, style: context.textTheme.bodyMedium),
          );
        }).toList(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.isDarkMode
                  ? AppColors.borderDark
                  : AppColors.borderLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedFilter.label,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: context.w10),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: context.isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
