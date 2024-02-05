import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';

import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMakerScreen extends StatefulWidget {
  const HomeMakerScreen({super.key});

  @override
  State<HomeMakerScreen> createState() => _HomeMakerScreenState();
}

class _HomeMakerScreenState extends State<HomeMakerScreen> {
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
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const RecipeDetailScreen(),
                      //   ),
                      // );
                    },
                    child: homeMakerWidget(context: context));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget homeMakerWidget({BuildContext? context}) {
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImage(
                  imagePath: "",
                  height: 35,
                  width: 35,
                ),
                Text(
                  "Demo User",
                  style: TextStyle(
                      fontSize: 13,
                      color: ColorConstant.black,
                      fontWeight: FontWeight.w500),
                ),
                FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: ColorConstant.black,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * .45,
            child: Image.asset(
              Images.homeMaker,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'About the home maker ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.mainColor,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text:
                          'how to prepare or make something, especially a of prepared food. A sub-recipe or sub recipe is a recipe for an that will be called for in the instructions for the main recipe.',
                      style: TextStyle(
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
