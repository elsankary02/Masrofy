import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceCubit extends Cubit<bool> {
  BalanceCubit() : super(true);
  void toggleBalanceVisibility() => emit(!state);
}
