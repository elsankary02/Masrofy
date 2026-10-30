import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class AppLogoWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.h40),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Icon(
        Icons.account_balance_wallet_rounded,
        color: AppColors.white,
        size: 48,
      ),
    );
  }
}
