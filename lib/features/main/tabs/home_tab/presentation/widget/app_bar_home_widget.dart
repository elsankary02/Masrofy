import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/app_images.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class AppBarHomeWidget extends StatelessWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const _UserAvatar(),
      title: const _Title(),
      subtitle: const _SubTitle(),
      trailing: const _NotificationButton(),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.isDarkMode ? AppColors.primary : AppColors.white,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.primary,
        backgroundImage: AssetImage(AppImages.mohamed),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      '${LocaleKeys.greeting.tr()} محمد ابراهيم',
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
    return Text(
      LocaleKeys.financial_freedom_quote.tr(),
      style: context.textTheme.bodySmall?.copyWith(
        color: context.isDarkMode
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
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
