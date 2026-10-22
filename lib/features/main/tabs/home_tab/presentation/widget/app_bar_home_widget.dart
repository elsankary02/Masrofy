import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/app_images.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class AppBarHomeWidget extends StatelessWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _UserAvatar(),
      title: _Title(),
      subtitle: _SubTitle(),

      trailing: _NotificationButton(),
    );
  }
}

// =============================================================================
// Local Widgets
// =============================================================================

/// Displays the user's avatar framed within a styled border.
class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
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

/// Displays the localized greeting and user name.
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      "${LocaleKeys.greeting.tr()} محمد ابراهيم",
      style: context.textTheme.titleLarge,
    );
  }
}

/// Displays the financial quote subtitle.
class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.financial_freedom_quote.tr(),
      style: context.textTheme.bodySmall!.copyWith(
        color: context.isDarkMode ? AppColors.grey400 : AppColors.grey500,
      ),
    );
  }
}

/// Notification icon button featuring an unread status badge.
class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => router.push(NamedRoutes.notification),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: AppColors.error,
              shape: .circle,
              border: Border.all(color: AppColors.white),
            ),
          ),
          Icon(
            Icons.notifications_none,
            size: 24,
            color: context.isDarkMode ? AppColors.grey200 : AppColors.grey900,
          ),
        ],
      ),
    );
  }
}
