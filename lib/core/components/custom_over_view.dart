import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class CustomOverView extends StatelessWidget {
  final Color? color, valueColor;
  final FaIconData? icon;
  final String title, price, currency;
  const CustomOverView({
    super.key,
    this.color,
    this.icon,
    required this.title,
    required this.price,
    required this.currency,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _Leading(color: color, icon: icon),
      title: _Title(title: title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(price, style: _style(context)),
          Text(currency, style: _style(context)),
        ],
      ),
    );
  }

  TextStyle? _style(BuildContext context) => context.textTheme.titleMedium
      ?.copyWith(color: valueColor, fontWeight: FontWeight.w700);
}

class _Leading extends StatelessWidget {
  const _Leading({required this.color, required this.icon});

  final Color? color;
  final FaIconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.h10),
      decoration: BoxDecoration(
        color: color!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: FaIcon(icon, color: color, size: 16),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.grey700,
      ),
    );
  }
}
