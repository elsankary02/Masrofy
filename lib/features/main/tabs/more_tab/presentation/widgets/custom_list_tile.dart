import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData icon;
  final Color? color;
  final Color? titleColor;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    this.subTitle,
    required this.icon,
    this.onTap,
    this.color,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color!.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              subTitle ?? '',
              style: context.textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
