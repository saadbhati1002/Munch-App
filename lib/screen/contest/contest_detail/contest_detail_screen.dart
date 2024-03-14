import 'package:app/models/contest/contest_model.dart';
import 'package:app/screen/contest/participate/participate_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContestDetailScreen extends StatefulWidget {
  final ContestData? contestData;
  const ContestDetailScreen({super.key, this.contestData});

  @override
  State<ContestDetailScreen> createState() => _ContestDetailScreenState();
}

class _ContestDetailScreenState extends State<ContestDetailScreen> {
  Future<bool> willPopScope() {
    Navigator.pop(context, widget.contestData!.numOfParticipate);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstant.backGroundColor,
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            Navigator.pop(context, widget.contestData!.numOfParticipate);
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${widget.contestData!.numOfParticipate} Participant",
                  style: const TextStyle(
                      fontSize: 12,
                      color: ColorConstant.black,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.contestData!.title ?? AppConstant.appName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.mainColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.contestData!.titleTagline ?? AppConstant.appName,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Rules',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.mainColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorConstant.greyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: widget.contestData!.rules!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Text(
                        '\u2022 1 ${widget.contestData!.rules![index]}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConstant.black,
                            fontWeight: FontWeight.w400),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonButton(
                  color: ColorConstant.mainColor,
                  textColor: ColorConstant.white,
                  title: "Participate",
                  onTap: () async {
                    var response = await Get.to(
                      () => ParticipateScreen(
                          contestID: widget.contestData!.id.toString()),
                    );
                    if (response != null) {
                      widget.contestData!.numOfParticipate = (int.parse(
                                  widget.contestData!.numOfParticipate ?? '0') +
                              1)
                          .toString();
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
