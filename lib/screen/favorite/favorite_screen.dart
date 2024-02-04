import 'package:app/screen/recipe/recipe_detail_screen.dart/recipe_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CommonDrawer(),
      key: _key,
      backgroundColor: ColorConstant.backGroundColor,
      appBar: customAppBar(
        _key,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Saved/liked',
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
                'The recipes that you love',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.greyColor,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                hintText: 'Search for recipe',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecipeDetailScreen(),
                        ),
                      );
                    },
                    child: recipeListWidget(context: context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
