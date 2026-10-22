import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class QuickToolsModel {
  final String subTitle;
  final FaIconData? icon;
  final Color? color;

  final String route;

  QuickToolsModel({
    required this.subTitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

List<QuickToolsModel> tools(BuildContext context) => [
  QuickToolsModel(
    subTitle: LocaleKeys.goals.tr(),
    icon: FontAwesomeIcons.bullseye,
    color: AppColors.purple,
    route: NamedRoutes.goals,
  ),
  QuickToolsModel(
    subTitle: LocaleKeys.debts.tr(),
    icon: FontAwesomeIcons.creditCard,
    color: AppColors.warning,
    route: NamedRoutes.debts,
  ),
  QuickToolsModel(
    subTitle: LocaleKeys.income.tr(),
    icon: FontAwesomeIcons.arrowTrendUp,
    color: AppColors.income,
    route: NamedRoutes.income,
  ),
  QuickToolsModel(
    subTitle: LocaleKeys.expense.tr(),
    icon: FontAwesomeIcons.bagShopping,
    color: AppColors.expense,
    route: NamedRoutes.expense,
  ),
];
