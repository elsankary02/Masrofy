import 'package:masrofy/features/debts/data/models/debts_model.dart';

abstract class DebtsRepository {
  List<DebtsModel> getDebts();
  Future<List<DebtsModel>> addDebt(DebtsModel debt);
  Future<List<DebtsModel>> updateDebt(DebtsModel debt);
  Future<List<DebtsModel>> deleteDebt(String id);
}
