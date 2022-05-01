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
      return _notifications = await NotificationServices.getUserNotifications();
    } else {
      return _notifications;
    }
  }
}
