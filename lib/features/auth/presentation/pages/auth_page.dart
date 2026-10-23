import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/auth/presentation/widgets/app_logo_widget.dart';
import 'package:masrofy/features/auth/presentation/widgets/auth_btn_widget.dart';
import 'package:masrofy/features/auth/presentation/widgets/welcome_header_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: Column(
              children: [
                AppLogoWidget(),
                WelcomeHeaderWidget(),
                AuthBtnWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
