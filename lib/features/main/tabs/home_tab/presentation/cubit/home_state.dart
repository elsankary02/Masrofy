import 'package:masrofy/features/main/tabs/home_tab/domain/entities/home_summary_entity.dart';

class HomeState {
  final HomeSummaryEntity summary;
  final bool isObscured;
  final bool isLoading;

  const HomeState({
    this.summary = const HomeSummaryEntity(),
    this.isObscured = false,
    this.isLoading = false,
  });

  HomeState copyWith({
    HomeSummaryEntity? summary,
    bool? isObscured,
    bool? isLoading,
  }) {
    return HomeState(
      summary: summary ?? this.summary,
      isObscured: isObscured ?? this.isObscured,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
