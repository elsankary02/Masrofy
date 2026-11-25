import 'package:flutter/material.dart';

import '../../../../../../core/router/go_router.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../../../core/widgets/custom_quick_tools.dart';
import '../../data/model/quick_tools_model.dart';

class QuickToolsHomeWidget extends StatelessWidget {
  final VoidCallback? onAfterReturn;

  const QuickToolsHomeWidget({super.key, this.onAfterReturn});

  @override
  Widget build(BuildContext context) {
    final quickTools = tools(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.h10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(quickTools.length, (index) {
          final tool = quickTools[index];
          return CustomQuickTools(
            subTitle: tool.subTitle,
            color: tool.color,
            icon: tool.icon,
            onTap: () async {
              await router.push(tool.route);
              onAfterReturn?.call();
            },
          );
        }),
      ),
    );
  }
}
