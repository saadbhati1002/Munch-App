import 'package:app/models/user/admin_user/admin_model.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class HomeMakerDetailScreen extends StatefulWidget {
  final AdminUser? userDetails;
  const HomeMakerDetailScreen({super.key, this.userDetails});

  @override
  State<HomeMakerDetailScreen> createState() => _HomeMakerDetailScreenState();
}

class _HomeMakerDetailScreenState extends State<HomeMakerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(
            context,
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CustomImageCircular(
                      imagePath: widget.userDetails!.image != null
                          ? "${AppConstant.imagePath}${widget.userDetails!.image}"
                          : null,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Text(
                    widget.userDetails!.name!,
                    style: const TextStyle(
                        fontSize: 13,
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.ellipsis,
                    color: ColorConstant.black,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (widget.userDetails!.mediaType == "IMAGE") ...[
              CustomImage(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .45,
                imagePath:
                    "${AppConstant.imagePath}${widget.userDetails!.video}",
              ),
            ] else ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(
                          milliseconds: AppConstant.pageAnimationDuration),
                      child: VideoPlayerScreen(
                        videoPath:
                            "${AppConstant.imagePath}${widget.userDetails!.video}",
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * .45,
                  child: Stack(
                    children: [
                      CustomImage(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * .45,
                        imagePath:
                            "${AppConstant.imagePath}${widget.userDetails!.thumbnail}",
                      ),
                      Center(
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.greyColor),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 35,
                            color: ColorConstant.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'About the home maker ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.mainColor,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: widget.userDetails!.desc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
