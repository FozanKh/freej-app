import 'package:freej/core/services/local/shared_pref.dart';

import '../models/notifications.dart';
import '../services/notification_services.dart';

class NotificationsRepository {
  NotificationsRepository._();
  static NotificationsRepository? _instance;
  static NotificationsRepository get instance => _instance ??= NotificationsRepository._();
  List<Notifications> _notifications = [];

  Future<void> init() async {
    await getAllNotifications();
  }

  Future<List<Notifications>> getAllNotifications({bool refresh = false}) async {
    if (_notifications.isEmpty || refresh) {
      _notifications = await NotificationServices.getUserNotifications();
      _notifications.sort();
    }
    return _notifications;
  }

  Future<bool> showNotificationBadge() async {
    try {
      if (_notifications.isEmpty) {
        await getAllNotifications();
      }
      return _notifications.first.createdAt.millisecondsSinceEpoch >
          ((await SharedPreference.instance.getLastNotificationCheck())?.millisecondsSinceEpoch ?? 0);
    } catch (e) {
      return false;
    }
  }

  void clear() {
    _notifications.clear();
  }
}
