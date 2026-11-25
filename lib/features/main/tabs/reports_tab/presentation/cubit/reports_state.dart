import '../../domain/entities/reports_entity.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final ReportsEntity report;

  ReportsLoaded(this.report);
}

class ReportsError extends ReportsState {
  final String message;

  ReportsError(this.message);
}
