import 'dart:convert';

import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/recipe/comment/add_comment_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCommentScreen extends StatefulWidget {
  final String? recipeID;

  const AddCommentScreen({super.key, this.recipeID});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool isLoading = false;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Comment',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.mainColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    context: context,
                    controller: titleController,
                    borderRadius: 10,
                    hintText: "Write the title",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    keyboardType: TextInputType.multiline,
                    context: context,
                    borderRadius: 10,
                    controller: commentController,
                    isMaxLine: true,
                    hintText: "Write your comment",
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    color: ColorConstant.mainColor,
                    textColor: ColorConstant.white,
                    title: "Submit",
                    onTap: () {
                      _addRecipeComment();
                    },
                  ),
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Future _addRecipeComment() async {
    if (titleController.text.isEmpty) {
      toastShow(message: "Please enter title");
      return;
    }
    if (commentController.text.isEmpty) {
      toastShow(message: "Please enter comment");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      AddCommentRes response = await RecipeRepository().addCommentApiCall(
        comment: commentController.text.trim(),
        recipeID: widget.recipeID,
        title: titleController.text.trim(),
      );
      if (response.success == true) {
        toastShow(message: response.message);
        response.data!.userName = AppConstant.userData!.name;
        response.data!.recipeId = int.parse(widget.recipeID!);
        response.data!.userImage = AppConstant.userData!.image != null
            ? AppConstant.imagePath + AppConstant.userData!.image.toString()
            : null;

        response.data!.description = commentController.text.trim();
        Get.back(result: jsonEncode(response.data));
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
