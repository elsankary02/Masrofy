import 'package:masrofy/features/main/tabs/home_tab/domain/entities/home_summary_entity.dart';

class HomeSummaryModel extends HomeSummaryEntity {
  const HomeSummaryModel({
    super.todayExpenses = 0,
    super.totalExpenses = 0,
    super.currentMonthIncome = 0,
    super.totalIncome = 0,
    super.remainingDebts = 0,
    super.completedGoalsCount = 0,
    super.totalGoalsCount = 0,
  });
}
