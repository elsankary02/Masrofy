import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/router/go_router.dart';
import '../../../../../../core/router/named_routes.dart';
import '../../../../../../core/services/shared_preferences.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../../../core/widgets/custom_btn.dart';
import '../../../home_tab/presentation/pages/home_tab.dart';
import '../../../reports_tab/presentation/pages/reports_tab.dart';
import '../../../transactions_tab/presentation/page/transactions_tab.dart';

class LogoutConfirmBottomSheet extends StatefulWidget {
  const LogoutConfirmBottomSheet({super.key});

  @override
  State<LogoutConfirmBottomSheet> createState() =>
      _LogoutConfirmBottomSheetState();
}

class _LogoutConfirmBottomSheetState extends State<LogoutConfirmBottomSheet> {
  bool _clearLocalData = true;
  bool _isClearing = false;

  static const List<String> _financialKeys = [
    'masrofy_expenses_list',
    'masrofy_incomes_list',
    'masrofy_debts_list',
    'masrofy_goals_list',
  ];

  Future<void> _confirmLogout() async {
    if (_isClearing) return;
    setState(() => _isClearing = true);

    if (_clearLocalData) {
      for (final key in _financialKeys) {
        await SPService.remove(key);
      }
      homeTabKey.currentState?.refreshHome();
      reportsTabKey.currentState?.refreshReports();
      transactionsTabKey.currentState?.refreshTransactions();
    }

    if (!mounted) return;
    Navigator.of(context).pop(_clearLocalData);
    router.go(NamedRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        context.h20,
        context.h20,
        context.h20,
        context.h25,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.h15,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
              Text(
                LocaleKeys.logout.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            LocaleKeys.logout_confirm_message.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          InkWell(
            onTap: () => setState(() => _clearLocalData = !_clearLocalData),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.grey200,
                ),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _clearLocalData,
                    activeColor: AppColors.error,
                    onChanged: (val) {
                      setState(() => _clearLocalData = val ?? false);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      LocaleKeys.clear_local_data.tr(),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: CustomBtn(
                  text: LocaleKeys.cancel.tr(),
                  variant: ButtonVariant.text,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              Expanded(
                child: CustomBtn(
                  text: _isClearing
                      ? LocaleKeys.in_progress.tr()
                      : LocaleKeys.logout.tr(),
                  onPressed: _confirmLogout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
