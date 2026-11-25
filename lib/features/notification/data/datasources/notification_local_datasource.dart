import 'dart:convert';

import '../../../../core/services/shared_preferences.dart';
import '../models/notification_model.dart';

abstract class NotificationLocalDataSource {
  List<NotificationModel> getNotifications();
  Future<void> saveNotifications(List<NotificationModel> items);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  static const _notificationsKey = 'masrofy_local_notifications';

  @override
  List<NotificationModel> getNotifications() {
    final raw = SPService.getString(_notificationsKey);
    if (raw == null || raw.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => NotificationModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveNotifications(List<NotificationModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toMap()).toList());
    await SPService.setString(_notificationsKey, encoded);
  }
}
