import 'package:freej/app/notification/models/notifications.dart';

import '../../../core/services/api/request_manager.dart';

class NotificationServices {
  static final _notificationsUrl = "${RequestManger.baseUrl}/notifications/";

  static Future<List<Notifications>> getUserNotifications() async {
    return (await RequestManger.fetchList(
      url: _notificationsUrl,
      method: Method.GET,
    ))
        .map((e) => Notifications.fromMap(e))
        .toList();
  }
}
