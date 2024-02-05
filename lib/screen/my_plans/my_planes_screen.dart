import 'package:app/utility/color.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class MyPlanesScreen extends StatefulWidget {
  const MyPlanesScreen({super.key});

  @override
  State<MyPlanesScreen> createState() => _MyPlanesScreenState();
}

class _MyPlanesScreenState extends State<MyPlanesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Meal Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.organColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Save, Schedule, Prepare',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.greyColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 37,
                    decoration: BoxDecoration(
                      color: ColorConstant.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Add a recipe",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorConstant.mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Friday",
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: const Text(
                      "14 Feb 2024",
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month,
                    color: ColorConstant.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return savedRecipe();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget savedRecipe() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: ColorConstant.greyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                imagePath: Images.recipe,
                isAssetsImage: true,
                width: MediaQuery.of(context).size.width * .35,
                height: 120,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name of the dish - ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.mainColor,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text:
                                'how to prepare or make something, especially a of prepared food. ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '14th February 2024 | 8:00 PM',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.greyDarkColor,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
