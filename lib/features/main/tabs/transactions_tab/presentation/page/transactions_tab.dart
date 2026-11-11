import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/presentation/widgets/transaction_item_builder.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/presentation/widgets/transactions_summary_card_widget.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            children: [
              TransactionsSummaryCardWidget(),
              SizedBox(height: context.h20),
              TransactionItemBuilder(),
              SizedBox(height: context.h20),
            ],
          ),
        ),
      ),
    );
  }
}
