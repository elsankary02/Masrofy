import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initMess();
    super.initState();
  }

  void initMess() {
    Future.delayed(Duration(seconds: 2), () {
      router.go(NamedRoutes.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.h40),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 45,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.white,
                    size: 85,
                  ),
                ),
                SizedBox(height: context.h40),

                // App name
                Text(
                  LocaleKeys.app_name.tr(),
                  style: context.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: context.h15),
                Text(
                  LocaleKeys.splash_tagline.tr(),
                  style: context.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: AppColors.primary.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                Container(
                  width: 55,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: AppColors.splashGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: context.h20),
                Text(
                  LocaleKeys.splash_welcome.tr(),
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
