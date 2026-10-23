import 'package:flutter/material.dart';
import 'package:masrofy/core/components/custom_quick_tools.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/home_tab/data/model/quick_tools_model.dart';

class QuikToolsHomeWidget extends StatelessWidget {
  const QuikToolsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.h10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(tools(context).length, (index) {
            final tool = tools(context)[index];
            return CustomQuickTools(
              subTitle: tool.subTitle,
              color: tool.color,
              icon: tool.icon,
              onTap: () => router.push(tool.route),
            );
          }),
        ],
      ),
    );
  }
}
