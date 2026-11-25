import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/router/go_router.dart';
import '../../../../core/router/named_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/widgets/custom_btn.dart';

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
