import 'dart:async';

import 'package:app/api/repository/user/user.dart';
import 'package:app/models/user/admin_user/admin_model.dart';
import 'package:app/screen/video_player/video_player_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/custom_image_view_circular.dart';
import 'package:app/widgets/recipe_skeleton.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class HomeMakerScreen extends StatefulWidget {
  const HomeMakerScreen({super.key});

  @override
  State<HomeMakerScreen> createState() => _HomeMakerScreenState();
}

class _HomeMakerScreenState extends State<HomeMakerScreen> {
  List<AdminUser> adminList = [];
  bool isLoading = false;
  Timer? _debounce;
  String? searchedName;
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
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      searchedName = query;
    });
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
                onChanged: _onSearchChanged,
                hintText: 'Search for home makers',
                prefix: const Icon(
                  Icons.search,
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
                      return searchedName == null || searchedName == ""
                          ? homeMakerWidget(
                              context: context,
                              userData: adminList[index],
                            )
                          : searchedName!.toLowerCase().contains(
                                  adminList[index].name!.toLowerCase())
                              ? homeMakerWidget(
                                  context: context,
                                  userData: adminList[index],
                                )
                              : const SizedBox();
                    },
                  )
                : ListView.builder(
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return recipeSkeleton(context: context);
                    },
                  ),
          ],
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
                GestureDetector(
                  onTap: () {},
                  child: CustomImageCircular(
                    imagePath: userData!.image != null
                        ? "${AppConstant.imagePath}${userData.image}"
                        : null,
                    height: 25,
                    width: 25,
                  ),
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
          if (userData.mediaType == "IMAGE") ...[
            CustomImage(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .45,
              imagePath: "${AppConstant.imagePath}${userData.video}",
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
                      videoPath: "${AppConstant.imagePath}${userData.video}",
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
                          "${AppConstant.imagePath}${userData.thumbnail}",
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
