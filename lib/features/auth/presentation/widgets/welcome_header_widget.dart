import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h20 = context.h * 0.020;
    final isDark = context.isDarkMode;
    return Column(
      children: [
        SizedBox(height: h20),
        Text(
          LocaleKeys.title.tr(),
          textAlign: .center,
          style: context.textTheme.displayLarge!.copyWith(
            color: isDark ? AppColors.white : AppColors.primary,
          ),
        ),
        SizedBox(height: h20 + 12),
        Text(
          LocaleKeys.welcome_back.tr(),
          textAlign: .center,
          style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.white : AppColors.primary,
          ),
        ),
        SizedBox(height: h20),
        Text(
          LocaleKeys.welcome_subtitle.tr(),
          textAlign: .center,
          style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.grey100 : AppColors.primary,
          ),
        ),
        SizedBox(height: h20),
      ],
    );
  }
}
