import 'dart:io';

import 'package:app/api/repository/category/category.dart';
import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/category/category_model.dart';
import 'package:app/models/recipe/create/create_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  TextEditingController recipeName = TextEditingController();
  TextEditingController recipeTagLine = TextEditingController();
  TextEditingController preparationTime = TextEditingController();
  TextEditingController cookingTime = TextEditingController();
  TextEditingController discretion = TextEditingController();
  TextEditingController severingPortion = TextEditingController();
  TextEditingController ingredientList = TextEditingController();
  TextEditingController method = TextEditingController();
  TextEditingController chiefWhisper = TextEditingController();
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<CategoryData> categoryList = [];
  List selectedCategoryIDList = [];
  File? recipeImage;
  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  Future _getCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      CategoryRes response = await CategoryRepository().getCategoryApiCall();
      if (response.data != null) {
        categoryList = response.data!;
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    imagePickerPopUp();
                  },
                  child: recipeImage != null
                      ? Container(
                          height: MediaQuery.of(context).size.height * .35,
                          width: MediaQuery.of(context).size.width * 1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(recipeImage!),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
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
                                "Upload photo",
                                style: TextStyle(
                                    color: ColorConstant.mainColor,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextWidget(title: 'Select Tags'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: SizedBox(
                    // height: 45,
                    child: MultiSelectBottomSheetField(
                      decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: ColorConstant.white,
                      // key: _multiSelectKey,
                      initialChildSize: 0.7,
                      maxChildSize: 0.9,
                      title: const Text("Select Recipe Tag"),
                      buttonText: const Text("Select Recipe Tag"),
                      items: categoryList
                          .map((data) =>
                              MultiSelectItem<CategoryData>(data, data.name!))
                          .toList(),
                      searchable: true,
                      validator: (values) => '',
                      onConfirm: (List values) {
                        for (int i = 0; i < values.length; i++) {
                          selectedCategoryIDList.add(values[i].id);
                        }
                      },
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 23,
                      ),
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (item) {},
                      ),
                    ),
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
                    controller: recipeName,
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
                    controller: recipeTagLine,
                    context: context,
                    hintText: 'Tagline',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextWidget(title: 'Preparation Time (in Mins)'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSearchTextField(
                    borderRadius: 10,
                    context: context,
                    controller: preparationTime,
                    keyboardType: TextInputType.number,
                    hintText: 'Preparation Time',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextWidget(title: 'Cooking Time (in Mins)'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSearchTextField(
                    borderRadius: 10,
                    context: context,
                    hintText: 'Cooking Time',
                    controller: cookingTime,
                    keyboardType: TextInputType.number,
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
                    controller: discretion,
                    hintText: 'Small Description',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextWidget(title: 'Serving Portions (in Numbers)'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSearchTextField(
                    borderRadius: 10,
                    context: context,
                    controller: severingPortion,
                    keyboardType: TextInputType.number,
                    hintText: 'Serving Portions',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextWidget(title: 'Ingredient List (Separate by ",")'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSearchTextField(
                    isMaxLine: true,
                    borderRadius: 10,
                    controller: ingredientList,
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
                    controller: method,
                    context: context,
                    hintText: 'Method',
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
                    controller: chiefWhisper,
                    context: context,
                    hintText: 'Chefs Whisper',
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
                    title: "Publish",
                    onTap: () {
                      _createRecipe();
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  void imagePickerPopUp() async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: ColorConstant.greyColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              elevation: 0,
              backgroundColor: ColorConstant.white,
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              title: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(15)),
                // height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload Recipe Image',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Text(
                              'Gallery',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromCamera();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Text(
                              'Camera',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  imageFromCamera() async {
    try {
      final XFile? result =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (result != null) {
        recipeImage = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  imageFromGallery() async {
    try {
      final XFile? result = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 60);
      if (result != null) {
        recipeImage = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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

  Future _createRecipe() async {
    if (recipeImage == null) {
      toastShow(message: "Please select recipe image");
      return;
    }

    if (selectedCategoryIDList.isEmpty) {
      toastShow(message: "Please select recipe tag");
      return;
    }
    if (recipeName.text.isEmpty) {
      toastShow(message: "Please enter dish name");
      return;
    }
    if (recipeTagLine.text.isEmpty) {
      toastShow(message: "Please enter tag line");
      return;
    }
    if (preparationTime.text.isEmpty) {
      toastShow(message: "Please enter preparation time");
      return;
    }
    if (cookingTime.text.isEmpty) {
      toastShow(message: "Please enter cooking time");
      return;
    }
    if (discretion.text.isEmpty) {
      toastShow(message: "Please enter description");
      return;
    }
    if (severingPortion.text.isEmpty) {
      toastShow(message: "Please enter serving portion");
      return;
    }
    if (ingredientList.text.isEmpty) {
      toastShow(message: "Please enter ingredient list");
      return;
    }
    if (method.text.isEmpty) {
      toastShow(message: "Please enter method");
      return;
    }

    if (chiefWhisper.text.isEmpty) {
      toastShow(message: "Please enter chief whisper");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      RecipeCreateRes response = await RecipeRepository().createRecipeApiCall(
        categoryID: selectedCategoryIDList
            .toString()
            .replaceAll('[', "")
            .replaceAll(']', ""),
        chefWhisper: chiefWhisper.text.toString().trim(),
        chefWhisperTagline: "",
        cookingTime: cookingTime.text.trim(),
        description: discretion.text.trim(),
        ingredientList: ingredientList.text.trim(),
        method: method.text.trim(),
        methodTagLine: "",
        preparationTime: preparationTime.text.trim(),
        recipeImage: recipeImage,
        recipeName: recipeName.text.trim(),
        servingPortion: severingPortion.text.trim(),
        tagLine: recipeTagLine.text.trim(),
      );
      if (response.success == true) {
        Get.back(result: "1");
        toastShow(
          message: "Recipe created successfully. Now wait for admin approval",
        );
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
