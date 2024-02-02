import 'package:app/screen/recipe_detail_screen.dart/recipe_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List mainBannerList = [Images.slider, Images.slider, Images.slider];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isRecipe = true;
  setStateNow() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CommonDrawer(),
      key: _key,
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBar(
        _key,
        context: context,
        setState: setStateNow(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              height: 45,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(width: 1, color: ColorConstant.greyColor),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: ColorConstant.greyColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search for Recipes",
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.greyColor,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: mainSlider(),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    height: 35,
                    decoration: BoxDecoration(
                      color: ColorConstant.greyColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRecipe = true;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .375,
                            decoration: BoxDecoration(
                              color: isRecipe
                                  ? ColorConstant.mainColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Recipe",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: isRecipe
                                      ? ColorConstant.white
                                      : ColorConstant.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRecipe = false;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .375,
                            decoration: BoxDecoration(
                              color: !isRecipe
                                  ? ColorConstant.mainColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Articles",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: !isRecipe
                                      ? ColorConstant.white
                                      : ColorConstant.greyDarkColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecipeDetailScreen(),
                          ),
                        );
                      },
                      child: recipeListWidget(context: context));
                }),
          ],
        ),
      ),
    );
  }

  Widget mainSlider() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .23,
      child: Swiper(
        scale: 0.75,
        pagination: const SwiperPagination(),
        viewportFraction: 0.95,
        itemCount: mainBannerList.length,
        onTap: (index) {
          // if (sponsorBannerList[index].bannerLink != null ||
          //     sponsorBannerList[index].bannerLink != "") {
          //   launchUrl(Uri.parse(sponsorBannerList[index].bannerLink!));
          // }
        },
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .23,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                image: DecorationImage(
                    image: AssetImage(Images.slider), fit: BoxFit.fill),
              ),
            ),
          );
          //  CachedNetworkImage(
          //   imageUrl: sponsorBannerList[index].bannerImage!,
          //   imageBuilder: (context, imageProvider) {
          //     return ClipRRect(
          //       borderRadius: BorderRadius.circular(15),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * .75,
          //         height: MediaQuery.of(context).size.height * .25,
          //         decoration: BoxDecoration(
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(5),
          //           ),
          //           image: DecorationImage(
          //             image: imageProvider,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          //   placeholder: (context, url) {
          //     return errorImageBuilder();
          //   },
          //   errorWidget: (context, url, error) {
          //     return errorImageBuilder();
          //   },
          // );
        },
      ),
    );
  }

  Widget errorImageBuilder() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      child: SkeletonTheme(
        themeMode: ThemeMode.light,
        child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            shape: BoxShape.rectangle,
            height: MediaQuery.of(context).size.height * .24,
            width: MediaQuery.of(context).size.width * 1,
          ),
        ),
      ),
    );
  }
}
