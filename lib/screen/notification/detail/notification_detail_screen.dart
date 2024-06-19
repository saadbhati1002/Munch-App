import 'package:app/models/notification/notification_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationDetailScreen extends StatefulWidget {
  final NotificationData? notificationData;
  const NotificationDetailScreen({super.key, this.notificationData});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.notificationData!.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ColorConstant.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(
                        DateTime.parse(widget.notificationData!.createdAt!),
                      )
                      .toString(),
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: ColorConstant.greyColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.notificationData!.desc ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorConstant.black),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
