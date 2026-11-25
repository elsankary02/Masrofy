import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../../../core/widgets/popup_menu_date_filter_widget.dart';
import '../../data/datasources/reports_local_datasource.dart';
import '../../data/repo/reports_repository_impl.dart';
import '../../domain/usecases/get_reports_usecase.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../widget/reports_by_category_widget.dart';
import '../widget/reports_data_grid_view_builder_widget.dart';

final GlobalKey<ReportsTabState> reportsTabKey = GlobalKey<ReportsTabState>();

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => ReportsTabState();
}

class ReportsTabState extends State<ReportsTab> with WidgetsBindingObserver {
  late final ReportsCubit _cubit;

  void refreshReports() {
    _cubit.loadReports();
  }

  String _mapDateFilterToKey(DateFilter filter) {
    final raw = filter.name.toLowerCase();
    if (raw.contains('week')) return 'this_week';
    if (raw.contains('last')) return 'last_month';
    if (raw.contains('year')) return 'this_year';
    return 'this_month';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final repo = ReportsRepositoryImpl(ReportsLocalDataSourceImpl());
    _cubit = ReportsCubit(GetReportsUseCase(repo))..loadReports();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshReports();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.summary_and_stats.tr(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _cubit.loadReports(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: context.h20),
              child: Column(
                children: [
                  PopupMenuDateFilterWidget(
                    onFilterChanged: (value) {
                      _cubit.loadReports(filterKey: _mapDateFilterToKey(value));
                    },
                    iconColor: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    borderColor: context.isDarkMode
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    titleColor: context.theme.colorScheme.onSurface,
                    color: context.isDarkMode
                        ? AppColors.cardDark
                        : Colors.white,
                  ),
                  SizedBox(height: context.h20),
                  BlocBuilder<ReportsCubit, ReportsState>(
                    builder: (context, state) {
                      if (state is ReportsLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ReportsError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(state.message),
                        );
                      }
                      if (state is ReportsLoaded) {
                        return Column(
                          children: [
                            ReportsDataGridViewBuilderWidget(
                              cards: state.report.summaryCards,
                            ),
                            SizedBox(height: context.h20),
                            ExpensesByCategoryWidget(
                              categories: state.report.categories,
                              totalAmount: state.report.totalExpensesAmount,
                            ),
                            SizedBox(height: context.h20),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
