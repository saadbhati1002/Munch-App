import 'package:app/api/network/notification/notification.dart';

class NotificationRepository {
  Future<dynamic> getNotificationApiCall() async {
    return await NotificationNetwork.getNotification();
  }
}
