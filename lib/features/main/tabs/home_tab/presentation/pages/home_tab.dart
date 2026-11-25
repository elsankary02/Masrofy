import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/home_tab/data/datasources/home_local_datasource.dart';
import 'package:masrofy/features/main/tabs/home_tab/data/repositories/home_repository_impl.dart';
import 'package:masrofy/features/main/tabs/home_tab/domain/usecases/get_home_summary_usecase.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/cubit/home_cubit.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/app_bar_home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/over_view__home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/quik_tools_home_widget.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/widget/summary_card_home_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    final repository = HomeRepositoryImpl(HomeLocalDataSourceImpl());
    _homeCubit = HomeCubit(GetHomeSummaryUseCase(repository))..loadSummary();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _homeCubit.loadSummary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: context.h20),
              child: Column(
                children: [
                  const AppBarHomeWidget(),
                  SizedBox(height: context.h20),
                  const SummaryCardHomeWidget(),
                  SizedBox(height: context.h30),
                  _CustomHeader(title: LocaleKeys.quick_tools.tr()),
                  SizedBox(height: context.h20),
                  QuickToolsHomeWidget(onAfterReturn: _homeCubit.loadSummary),
                  SizedBox(height: context.h30),
                  _CustomHeader(title: LocaleKeys.overview.tr()),
                  SizedBox(height: context.h20),
                  const OverViewHomeWidget(),
                  SizedBox(height: context.h60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  final String title;
  const _CustomHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
