import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/datasource/goals_local_datasource.dart';
import '../../data/models/goals_card_model.dart';
import '../../data/repos/goals_repository.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_status_cubit.dart';
import '../widget/goals_bottom_sheet_widget.dart';
import '../widget/goals_card_widget.dart';
import '../widget/goals_summary_card_widget.dart';
import '../widget/goals_tab_bar_widget.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  late final GoalsCubit _goalsCubit;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goalsCubit = GoalsCubit(GoalsRepositoryImpl(GoalsLocalDataSourceImpl()))
      ..loadGoals();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _currentController.dispose();
    _targetController.dispose();
    _goalsCubit.close();
    super.dispose();
  }

  void _showValidationSnackBar(BuildContext targetContext, String message) {
    ScaffoldMessenger.of(targetContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _openGoalForm({GoalsCardModel? goal}) {
    final isEditing = goal != null;
    _titleController.text = goal?.title ?? '';
    _currentController.text = goal == null ? '' : goal.current.toString();
    _targetController.text = goal == null ? '' : goal.target.toString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider.value(
          value: _goalsCubit,
          child: GoalsBottomSheetWidget(
            isEditing: isEditing,
            titleController: _titleController,
            currentController: _currentController,
            targetController: _targetController,
            onDelete: isEditing
                ? () async {
                    await _goalsCubit.deleteGoal(goal.id);
                    if (!sheetContext.mounted) return;
                    Navigator.pop(sheetContext);
                  }
                : null,
            onSave: () async {
              final title = _titleController.text.trim();
              final currentText = _currentController.text.trim();
              final targetText = _targetController.text.trim();

              final num? parsedCurrent = currentText.isEmpty
                  ? 0
                  : num.tryParse(currentText);
              final num? parsedTarget = targetText.isEmpty
                  ? null
                  : num.tryParse(targetText);

              if (title.isEmpty) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_goal_title_required.tr(),
                );
                return;
              }

              if (parsedCurrent == null) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_goal_current_invalid.tr(),
                );
                return;
              }

              if (parsedCurrent < 0) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_goal_current_negative.tr(),
                );
                return;
              }

              if (parsedTarget == null) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_goal_target_invalid.tr(),
                );
                return;
              }

              if (parsedTarget <= 0) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_goal_target_positive.tr(),
                );
                return;
              }

              final palette = [
                AppColors.purple,
                AppColors.cyan,
                AppColors.saving,
              ];
              final cardColor =
                  goal?.color ??
                  palette[_goalsCubit.state.goals.length % palette.length];
              final cardIconKey = goal?.iconKey ?? 'flag';

              final item = GoalsCardModel(
                id: goal?.id ?? '',
                title: title,
                current: parsedCurrent,
                target: parsedTarget,
                color: cardColor,
                iconKey: cardIconKey,
              );

              if (isEditing) {
                await _goalsCubit.updateGoal(item);
              } else {
                await _goalsCubit.addGoal(item);
              }

              if (!sheetContext.mounted) return;
              Navigator.pop(sheetContext);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _goalsCubit,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.financial_goals.tr(),
                  onPressed: () => _openGoalForm(),
                ),
                SizedBox(height: context.h20),
                const GoalsSummaryCardWidget(),
                SizedBox(height: context.h20),
                const GoalsTabBarWidget(),
                SizedBox(height: context.h25),
                BlocBuilder<GoalsCubit, GoalsState>(
                  builder: (context, state) {
                    if (state.isLoading && state.goals.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: context.h40),
                        child: const CircularProgressIndicator(),
                      );
                    }
                    return _GoalsListView(
                      goals: state.goals,
                      status: state.status,
                      onEdit: (goal) => _openGoalForm(goal: goal),
                    );
                  },
                ),
                SizedBox(height: context.h60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoalsListView extends StatelessWidget {
  final List<GoalsCardModel> goals;
  final GoalsStatus status;
  final ValueChanged<GoalsCardModel> onEdit;

  const _GoalsListView({
    required this.goals,
    required this.status,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final filteredGoals = goals.where((goal) {
      if (status == GoalsStatus.active) {
        return goal.isActive;
      }
      return goal.isCompleted;
    }).toList();

    if (filteredGoals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            LocaleKeys.no_goals.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredGoals.length,
      separatorBuilder: (context, index) => SizedBox(height: context.h20),
      itemBuilder: (context, index) {
        final goal = filteredGoals[index];
        return GoalsCardWidget(goal: goal, onTap: () => onEdit(goal));
      },
    );
  }
}
