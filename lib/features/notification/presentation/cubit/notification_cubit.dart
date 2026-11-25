import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/notification_local_datasource.dart';
import '../../data/models/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationLocalDataSource _localDataSource;

  NotificationCubit(this._localDataSource) : super(const NotificationState());

  void loadNotifications() {
    final items = _localDataSource.getNotifications();
    emit(state.copyWith(notifications: items));
  }

  Future<void> addNotification({
    required String title,
    required String body,
  }) async {
    final newItem = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      createdAt: DateTime.now(),
      isRead: false,
    );
    final updated = [newItem, ...state.notifications];
    await _localDataSource.saveNotifications(updated);
    emit(state.copyWith(notifications: updated));
  }

  Future<void> markAsRead(String id) async {
    final updated = state.notifications
        .map((item) => item.id == id ? item.copyWith(isRead: true) : item)
        .toList();
    await _localDataSource.saveNotifications(updated);
    emit(state.copyWith(notifications: updated));
  }

  Future<void> clearAll() async {
    await _localDataSource.saveNotifications([]);
    emit(state.copyWith(notifications: []));
  }
}
