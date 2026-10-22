import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/widgets/custom_btn.dart';

class AuthBtnWidget extends StatelessWidget {
  const AuthBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      text: LocaleKeys.google_sign_in.tr(),
      icon: FaIcon(FontAwesomeIcons.google, size: 20, color: AppColors.primary),
      variant: ButtonVariant.outlined,
      style: context.textTheme.titleMedium,
      onPressed: () {
        router.go(NamedRoutes.main);
      },
    );
  }
}
