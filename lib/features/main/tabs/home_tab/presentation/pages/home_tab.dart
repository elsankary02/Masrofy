import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../data/datasources/home_local_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/get_home_summary_usecase.dart';
import '../cubit/home_cubit.dart';
import '../widget/app_bar_home_widget.dart';
import '../widget/over_view__home_widget.dart';
import '../widget/quik_tools_home_widget.dart';
import '../widget/summary_card_home_widget.dart';

final GlobalKey<HomeTabState> homeTabKey = GlobalKey<HomeTabState>();

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> with WidgetsBindingObserver {
  late final HomeCubit _homeCubit;

  void refreshHome() {
    _homeCubit.loadSummary();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final repository = HomeRepositoryImpl(HomeLocalDataSourceImpl());
    _homeCubit = HomeCubit(GetHomeSummaryUseCase(repository))..loadSummary();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshHome();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
            color: context.isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }
}
