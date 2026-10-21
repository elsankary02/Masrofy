import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.income.tr(),
          style: context.textTheme.titleLarge,
          textAlign: .center,
        ),
      ),
    );
  }
}
