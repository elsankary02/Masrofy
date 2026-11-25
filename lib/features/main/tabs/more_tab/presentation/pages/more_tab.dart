import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../cubits/locale_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/logout_confirm_bottom_sheet.dart';
import '../widgets/more_custom_card_section.dart';
import '../widgets/more_custom_list_tile.dart';
import '../widgets/more_setting_bottom_sheet.dart';
import '../widgets/more_summary_card.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.more.tr(),
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              MoreSummaryCard(),
              SizedBox(height: context.h40),
              CustomCardSection(
                title: LocaleKeys.change_theme.tr(),
                children: [
                  CustomListTile(
                    title: LocaleKeys.change_language.tr(),
                    subTitle: getLocaleSubTitle(context),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => SettingBottomSheet(isTheme: false),
                    ),
                    icon: Icons.language,
                    color: AppColors.primary,
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: context.isDarkMode
                        ? AppColors.dividerDark
                        : AppColors.grey200,
                  ),
                  CustomListTile(
                    title: LocaleKeys.change_theme.tr(),
                    subTitle: getThemeSubTitle(context),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => SettingBottomSheet(isTheme: true),
                    ),
                    icon: Icons.brightness_6,
                    color: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(height: context.h40),
              CustomCardSection(
                title: LocaleKeys.logout.tr(),
                children: [
                  CustomListTile(
                    title: LocaleKeys.logout.tr(),
                    titleColor: AppColors.error,
                    icon: Icons.logout,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const LogoutConfirmBottomSheet(),
                    ),
                    color: AppColors.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
