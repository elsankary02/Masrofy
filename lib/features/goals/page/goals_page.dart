import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/components/custom_appbar.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/goals/widget/goal_tab_item_widget.dart';
import 'package:masrofy/features/goals/widget/summary_card_goals_widget.dart';

enum GoalStatus { active, completed }

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  GoalStatus selectedStatus = GoalStatus.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              CustomAppBar(title: LocaleKeys.financial_goals.tr()),
              SizedBox(height: context.h20),
              SummaryCardGoalsWidget(total: '4', achieved: '5'),
              SizedBox(height: context.h20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GoalTabItemWidget(
                    title: LocaleKeys.status_active.tr(),
                    selected: selectedStatus == GoalStatus.active,
                    onTap: () {
                      setState(() {
                        selectedStatus = GoalStatus.active;
                      });
                    },
                  ),
                  GoalTabItemWidget(
                    title: LocaleKeys.completed_goals.tr(),
                    selected: selectedStatus == GoalStatus.completed,
                    onTap: () => setState(() {
                      selectedStatus = GoalStatus.completed;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
