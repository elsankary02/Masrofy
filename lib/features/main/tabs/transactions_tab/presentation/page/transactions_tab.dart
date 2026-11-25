import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../data/datasources/transactions_local_datasource.dart';
import '../../data/repositories/transactions_repository_impl.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../cubit/transactions_cubit.dart';
import '../widgets/transaction_item_builder.dart';
import '../widgets/transactions_summary_card_widget.dart';

final GlobalKey<TransactionsTabState> transactionsTabKey =
    GlobalKey<TransactionsTabState>();

class TransactionsTab extends StatefulWidget {
  const TransactionsTab({super.key});

  @override
  State<TransactionsTab> createState() => TransactionsTabState();
}

class TransactionsTabState extends State<TransactionsTab>
    with WidgetsBindingObserver {
  late final TransactionsCubit _cubit;

  void refreshTransactions() {
    _cubit.loadTransactions();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final repo = TransactionsRepositoryImpl(TransactionsLocalDataSourceImpl());
    _cubit = TransactionsCubit(GetTransactionsUseCase(repo))
      ..loadTransactions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshTransactions();
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
          centerTitle: true,
          title: Text(
            LocaleKeys.transactions.tr(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _cubit.loadTransactions,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: context.h20),
              child: Column(
                children: [
                  const TransactionsSummaryCardWidget(),
                  SizedBox(height: context.h20),
                  const TransactionItemBuilder(),
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
