import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Column(
      children: [
        SizedBox(height: context.h20),
        Text(
          LocaleKeys.title.tr(),
          textAlign: .center,
          style: context.textTheme.displayLarge!.copyWith(
            color: isDark ? AppColors.white : AppColors.primary,
          ),
        ),
        SizedBox(height: context.h35),
        Text(
          LocaleKeys.welcome_back.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.white : AppColors.primary,
          ),
        ),
        SizedBox(height: context.h20),
        Text(
          LocaleKeys.welcome_subtitle.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.grey100 : AppColors.primary,
          ),
        ),
        SizedBox(height: context.h20),
      ],
    );
  }
}
