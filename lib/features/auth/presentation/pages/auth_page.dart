import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/auth_btn_widget.dart';
import '../widgets/welcome_header_widget.dart';

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
