import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
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
            Container(
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * 1,
              color: ColorConstant.greyColor,
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: ColorConstant.black,
                    size: 25,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Upload video or photo",
                    style: TextStyle(
                        color: ColorConstant.mainColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Select Date and Time'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Select Date and Time',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Select Tags'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Select Tags',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Name of the Dish'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Name of the Dish',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Tagline'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Tagline',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Preparation Time'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Preparation Time',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Cooking Time'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Cooking Time',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Small Description'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                isMaxLine: true,
                borderRadius: 10,
                context: context,
                hintText: 'Small Description',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Serving Portions'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Serving Portions',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Ingredient List'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                isMaxLine: true,
                borderRadius: 10,
                context: context,
                hintText: 'Ingredient List',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Method'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                isMaxLine: true,
                borderRadius: 10,
                context: context,
                hintText: 'Method',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Method Tagline'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Method Tagline',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Chefs Whisper'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                isMaxLine: true,
                borderRadius: 10,
                context: context,
                hintText: 'Chefs Whisper',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonTextWidget(title: 'Chefs Whisper Tagline'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomSearchTextField(
                borderRadius: 10,
                context: context,
                hintText: 'Chefs Whisper Tagline',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CommonButton(
                color: ColorConstant.mainColor,
                textColor: ColorConstant.white,
                title: "Add to Calender",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTextWidget({String? title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title!,
        style: const TextStyle(
            fontSize: 14,
            color: ColorConstant.mainColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
