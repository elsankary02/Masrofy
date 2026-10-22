import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  const CustomAppBar({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: FaIcon(
            FontAwesomeIcons.arrowRight,
            color: context.theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        Text(
          title,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: FaIcon(
            FontAwesomeIcons.plus,
            color: context.theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ],
    );
  }
}
