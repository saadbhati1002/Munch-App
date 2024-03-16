import 'package:app/api/http_manager.dart';
import 'package:app/models/notification/notification_model.dart';

class NotificationNetwork {
  static const String notificationUrl = "notifications";
  static Future<dynamic> getNotification() async {
    final result = await httpManager.get(url: notificationUrl);
    NotificationRes loginRes = NotificationRes.fromJson(result);
    return loginRes;
  }
}
