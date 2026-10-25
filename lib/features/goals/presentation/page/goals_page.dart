import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/components/custom_appbar.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/goals/data/models/goals_card_model.dart';
import 'package:masrofy/features/goals/presentation/cubit/goals_status_cubit.dart';
import 'package:masrofy/features/goals/presentation/widget/goal_bottom_sheet_widget.dart';
import 'package:masrofy/features/goals/presentation/widget/goal_card_widget.dart';
import 'package:masrofy/features/goals/presentation/widget/goal_summary_card_widget.dart';
import 'package:masrofy/features/goals/presentation/widget/goal_tab_item_widget.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoalsStatusCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: BlocBuilder<GoalsStatusCubit, GoalStatus>(
              builder: (context, state) {
                final filteredGoals = goalModel.where((goal) {
                  if (state == GoalStatus.active) {
                    return goal.isAcitve;
                  } else {
                    return !goal.isAcitve;
                  }
                }).toList();
                return Column(
                  children: [
                    CustomAppBar(
                      title: LocaleKeys.financial_goals.tr(),
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => GoalBottomSheetWidget(
                          isEditing: false,
                          onSave: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: context.h20),
                    SummaryCardGoalsWidget(total: '2', achieved: '8'),
                    SizedBox(height: context.h20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GoalTabItemWidget(
                          title: LocaleKeys.status_active.tr(),
                          selected: state == GoalStatus.active,
                          onTap: () => context
                              .read<GoalsStatusCubit>()
                              .changeGoalStatus(GoalStatus.active),
                        ),
                        GoalTabItemWidget(
                          title: LocaleKeys.completed_goals.tr(),
                          selected: state == GoalStatus.completed,
                          onTap: () => context
                              .read<GoalsStatusCubit>()
                              .changeGoalStatus(GoalStatus.completed),
                        ),
                      ],
                    ),
                    SizedBox(height: context.h40),
                    filteredGoals.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text(
                                LocaleKeys.no_goals.tr(),
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredGoals.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: context.h20),
                            itemBuilder: (context, index) {
                              final goal = filteredGoals[index];
                              return GoalCardWidget(
                                onTap: () => showModalBottomSheet(
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (context) => GoalBottomSheetWidget(
                                    isEditing: true,
                                    onSave: () {},
                                    onDelete: () => router.pop(),
                                  ),
                                ),
                                goal: goal,
                              );
                            },
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
