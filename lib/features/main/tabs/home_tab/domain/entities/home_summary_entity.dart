class HomeSummaryEntity {
  final int todayExpenses;
  final int totalExpenses;
  final int currentMonthIncome;
  final int totalIncome;
  final int remainingDebts;
  final int completedGoalsCount;
  final int totalGoalsCount;

  const HomeSummaryEntity({
    this.todayExpenses = 0,
    this.totalExpenses = 0,
    this.currentMonthIncome = 0,
    this.totalIncome = 0,
    this.remainingDebts = 0,
    this.completedGoalsCount = 0,
    this.totalGoalsCount = 0,
  });

  int get totalBalance => totalIncome - totalExpenses;
}
