import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class TransactionsItemsModels {
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final IconData? icon;
  final Color? iconColor;
  final bool? isHighlighted;

  TransactionsItemsModels({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    required this.icon,
    required this.iconColor,
    this.isHighlighted = false,
  });
}

class TransactionsModels {
  final String date;
  final List<TransactionsItemsModels> items;

  TransactionsModels({required this.items, required this.date});
}

final List<TransactionsModels> transactionsList = [
  TransactionsModels(
    date: LocaleKeys.today.tr(),
    items: [
      TransactionsItemsModels(
        title: LocaleKeys.restaurant.tr(),
        subtitle: LocaleKeys.lunch_with_friends.tr(),
        time: '12:30 م',
        amount: '180',
        icon: Icons.restaurant_rounded,
        iconColor: AppColors.expense,
        isHighlighted: true,
      ),
      TransactionsItemsModels(
        title: LocaleKeys.transportation.tr(),
        subtitle: LocaleKeys.metro.tr(),
        time: '08:15 ص',
        amount: '20',
        icon: Icons.directions_car_rounded,
        iconColor: AppColors.blue,
      ),
      TransactionsItemsModels(
        title: LocaleKeys.coffee.tr(),
        subtitle: LocaleKeys.starbucks.tr(),
        time: '07:45 ص',
        amount: '45',
        icon: Icons.local_cafe_rounded,
        iconColor: AppColors.orange,
      ),
      TransactionsItemsModels(
        title: LocaleKeys.shopping.tr(),
        subtitle: LocaleKeys.supermarket.tr(),
        time: '06:30 م',
        amount: '215',
        icon: Icons.shopping_bag_rounded,
        iconColor: AppColors.success,
      ),
    ],
  ),
  TransactionsModels(
    date: LocaleKeys.yesterday.tr(),
    items: [
      TransactionsItemsModels(
        title: LocaleKeys.bills.tr(),
        subtitle: LocaleKeys.electricity_bill.tr(),
        time: '4:30 م',
        amount: '350',
        icon: Icons.electric_bolt_rounded,
        iconColor: AppColors.purple,
        isHighlighted: true,
      ),
      TransactionsItemsModels(
        title: LocaleKeys.shopping.tr(),
        subtitle: LocaleKeys.clothes.tr(),
        time: '2:15 م',
        amount: '320',
        icon: Icons.shopping_bag_rounded,
        iconColor: AppColors.success,
      ),
    ],
  ),
];
