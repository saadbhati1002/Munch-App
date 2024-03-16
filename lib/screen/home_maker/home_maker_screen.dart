import 'dart:io';

import 'package:app/api/repository/user/user.dart';
import 'package:app/models/user/admin_user/admin_model.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HomeMakerScreen extends StatefulWidget {
  const HomeMakerScreen({super.key});

  @override
  State<HomeMakerScreen> createState() => _HomeMakerScreenState();
}

class _HomeMakerScreenState extends State<HomeMakerScreen> {
  List<AdminUser> adminList = [];
  bool isLoading = false;
  @override
  void initState() {
    _getAdminUser();
    super.initState();
  }

  Future _getAdminUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      AdminRes response = await UserRepository().getUserApiCall();
      if (response.data.isNotEmpty) {
        adminList = response.data;
        _getVideoThumbnail();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getVideoThumbnail() async {
    for (int i = 0; i < adminList.length; i++) {
      if (adminList[i].video.toString().contains(".mp4")) {
        setState(() {
          adminList[i].isVideoThumbnailLoading = true;
        });

        adminList[i].videoThumbnail = await VideoThumbnail.thumbnailFile(
            video: "${AppConstant.imagePath}${adminList[i].video}",
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            quality: 75,
            maxHeight: 100);
        if (mounted) {
          setState(() {
            adminList[i].isVideoThumbnailLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: titleAppBar(
        context: context,
        title: "Home Maker",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                hintText: 'Search for home makers',
                prefix: const Icon(
                  Icons.search,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
                suffix: const Icon(
                  Icons.filter_alt_rounded,
                  size: 25,
                  color: ColorConstant.greyColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading == false
                ? ListView.builder(
                    itemCount: adminList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return homeMakerWidget(
                        context: context,
                        userData: adminList[index],
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return recipeSkeleton();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget recipeSkeleton() {
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SkeletonTheme(
              themeMode: ThemeMode.light,
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homeMakerWidget({BuildContext? context, AdminUser? userData}) {
    return SizedBox(
      width: MediaQuery.of(context!).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1.5,
            decoration: const BoxDecoration(color: ColorConstant.greyDarkColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageCircular(
                  imagePath: userData!.image,
                  height: 25,
                  width: 25,
                ),
                Text(
                  userData.name!,
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
          userData.video.toString().contains('.mp4')
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => VideoPlayerScreen(
                          videoPath:
                              "${AppConstant.imagePath}${userData.video}",
                        ));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * .45,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * .45,
                          child: userData.isVideoThumbnailLoading == true
                              ? Container(
                                  color: ColorConstant.white,
                                )
                              : Image.file(
                                  File(userData.videoThumbnail ?? ""),
                                  fit: BoxFit.fill,
                                ),
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
              : CustomImage(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * .45,
                  imagePath: userData.video,
                ),
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
                      text: userData.desc,
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
    );
  }
}
