import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/cubits/locale_cubit.dart';
import 'package:masrofy/features/main/tabs/more_tab/presentation/cubits/theme_cubit.dart';

class SettingBottomSheet extends StatefulWidget {
  final bool isTheme;

  const SettingBottomSheet({super.key, required this.isTheme});

  @override
  State<SettingBottomSheet> createState() => _SettingBottomSheetState();
}

class _SettingBottomSheetState extends State<SettingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 15,
        mainAxisSize: .min,
        children: [
          if (widget.isTheme == true) ...[
            LisTileBottomSheet(
              isSelected: mode == ThemeMode.system,
              title: LocaleKeys.system_theme.tr(),
              onTap: () =>
                  context.read<ThemeCubit>().changeTheme(ThemeMode.system),
            ),
            LisTileBottomSheet(
              isSelected: mode == ThemeMode.dark,
              title: LocaleKeys.dark_theme.tr(),
              onTap: () =>
                  context.read<ThemeCubit>().changeTheme(ThemeMode.dark),
            ),
            LisTileBottomSheet(
              isSelected: mode == ThemeMode.light,
              title: LocaleKeys.light_theme.tr(),
              onTap: () =>
                  context.read<ThemeCubit>().changeTheme(ThemeMode.light),
            ),
          ] else ...[
            LisTileBottomSheet(
              isSelected: locale.languageCode == 'en',
              title: LocaleKeys.english.tr(),
              onTap: () => context.read<LocaleCubit>().changeLocale(
                context,
                Locale('en'),
              ),
            ),
            LisTileBottomSheet(
              isSelected: locale.languageCode == 'ar',
              title: LocaleKeys.arabic.tr(),
              onTap: () => context.read<LocaleCubit>().changeLocale(
                context,
                Locale('ar'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class LisTileBottomSheet extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback? onTap;
  const LisTileBottomSheet({
    super.key,
    required this.isSelected,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : (context.isDarkMode ? AppColors.cardDark : AppColors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (context.isDarkMode
                      ? AppColors.borderDark
                      : AppColors.grey200),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : null,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
