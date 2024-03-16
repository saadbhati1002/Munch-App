import 'package:app/api/repository/notification/notification.dart';
import 'package:app/models/notification/notification_model.dart';
import 'package:app/screen/notification/detail/notification_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> notificationList = [];
  bool isLoading = false;
  @override
  void initState() {
    _getNotification();
    super.initState();
  }

  _getNotification() async {
    try {
      setState(() {
        isLoading = true;
      });
      NotificationRes response =
          await NotificationRepository().getNotificationApiCall();
      if (response.data != null) {
        notificationList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: titleAppBar(
        context: context,
        title: "Back",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: isLoading
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return notificationSkeleton();
              },
            )
          : notificationList.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * 1,
                  child: const Center(
                    child: Text(
                      "No Notification Found",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: notificationList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return notificationWidget(index);
                  },
                ),
    );
  }

  Widget notificationWidget(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => NotificationDetailScreen(
              notificationData: notificationList[index],
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                notificationList[index].title ?? '',
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                notificationList[index].desc ?? '',
                maxLines: 3,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorConstant.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(notificationList[index].createdAt!))
                    .toString(),
                maxLines: 3,
                style: const TextStyle(
                    fontFamily: "inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: ColorConstant.greyColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: ColorConstant.black,
            )
          ],
        ),
      ),
    );
  }

  Widget notificationSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 150, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}
