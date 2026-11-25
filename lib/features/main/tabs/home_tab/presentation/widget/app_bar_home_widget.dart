import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/router/go_router.dart';
import '../../../../../../core/router/named_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';

class AppBarHomeWidget extends StatelessWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      title: const _Title(),
      subtitle: const _SubTitle(),
      trailing: const _NotificationButton(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.home_welcome_masrofy.tr(),
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: context.isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.textPrimaryLight,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 8),
      child: Text(
        LocaleKeys.financial_freedom_quote.tr(),
        style: context.textTheme.bodySmall?.copyWith(
          color: context.isDarkMode
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => router.push(NamedRoutes.notification),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: context.h10,
              width: context.h10,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.isDarkMode
                      ? AppColors.surfaceDark
                      : AppColors.white,
                ),
              ),
            ),
            Icon(
              Icons.notifications_none_rounded,
              size: 26,
              color: context.isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
