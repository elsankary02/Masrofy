import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/widgets/custom_card_section.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/widgets/custom_list_tile.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/widgets/more_summary_card.dart';

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
                    subTitle: 'العربية',
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(),
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
                    subTitle: 'تلقائي',
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(),
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
                      builder: (context) => Container(),
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
