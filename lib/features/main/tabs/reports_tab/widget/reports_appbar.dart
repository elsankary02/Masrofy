import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class ReportsAppBar extends StatelessWidget {
  const ReportsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "title",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: () {},
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
