import 'package:app/api/repository/contest/contest.dart';
import 'package:app/models/contest/contest_model.dart';
import 'package:app/models/contest/contest_user_model.dart';
import 'package:app/screen/contest/participate/participate_screen.dart';
import 'package:app/screen/image_view/image_view.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_transition/page_transition.dart';

class ContestDetailScreen extends StatefulWidget {
  final ContestData? contestData;
  const ContestDetailScreen({super.key, this.contestData});

  @override
  State<ContestDetailScreen> createState() => _ContestDetailScreenState();
}

class _ContestDetailScreenState extends State<ContestDetailScreen> {
  bool isLoading = false;
  List<ParticipantsData> userList = [];
  @override
  void initState() {
    getParticipateUser();
    super.initState();
  }

  Future getParticipateUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      ContestUserRes response = await ContestRepository()
          .getContestParticipateApiCall(
              contestID: widget.contestData!.id.toString());
      if (response.participants.isNotEmpty) {
        for (int i = 0; i < response.participants.length; i++) {
          if (response.participants[i].isWinner == "1") {
            userList.add(response.participants[i]);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        body: Stack(
          children: [
            SingleChildScrollView(
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
                    if (widget.contestData!.media.isNotEmpty) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          itemCount: widget.contestData!.media.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(
                                        milliseconds:
                                            AppConstant.pageAnimationDuration),
                                    child: FullImageScreen(
                                      imageUrl:
                                          widget.contestData!.media[index],
                                    ),
                                  ),
                                );
                              },
                              child: CustomImage(
                                borderRadius: 15,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                imagePath: widget.contestData!.media[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: ColorConstant.greyColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.contestData!.rules!,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (userList.isNotEmpty) ...[
                      const Text(
                        'Winners',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.mainColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return userWidget(userList[index]);
                          })
                    ],
                    userList.isEmpty
                        ? CommonButton(
                            color: ColorConstant.mainColor,
                            textColor: ColorConstant.white,
                            title: "Participate",
                            onTap: () async {
                              var response = await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  duration: Duration(
                                      milliseconds:
                                          AppConstant.pageAnimationDuration),
                                  child: ParticipateScreen(
                                      contestID:
                                          widget.contestData!.id.toString()),
                                ),
                              );
                              if (response != null) {
                                widget.contestData!.numOfParticipate =
                                    (int.parse(widget.contestData!
                                                    .numOfParticipate ??
                                                '0') +
                                            1)
                                        .toString();
                                setState(() {});
                              }
                            },
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            isLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget userWidget(ParticipantsData? userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              width: 60,
              height: 60,
              imagePath: userData!.userImage,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .745,
              child: Text(
                userData.userName ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
