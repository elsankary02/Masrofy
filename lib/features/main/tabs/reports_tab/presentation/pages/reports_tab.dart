import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/reports_tab/presentation/widget/dashboard_date_filter_dropdown.dart';
import 'package:masrofy/features/main/tabs/reports_tab/presentation/widget/expenses_by_category_widget.dart';
import 'package:masrofy/features/main/tabs/reports_tab/presentation/widget/reports_data_grid_view_builder_widget.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              DashboardDateFilterDropdown(onFilterChanged: (value) {}),
              SizedBox(height: context.h20),
              ReportsDataGridViewBuilderWidget(),
              SizedBox(height: context.h20),
              ExpensesByCategoryWidget(),
              SizedBox(height: context.h20),
            ],
          ),
        ),
      ),
    );
  }
}
