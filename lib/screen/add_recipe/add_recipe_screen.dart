import 'dart:io';

import 'package:app/api/repository/category/category.dart';
import 'package:app/api/repository/recipe/recipe.dart';
import 'package:app/models/category/category_model.dart';
import 'package:app/models/recipe/create/create_model.dart';
import 'package:app/screen/dashboard/dashboard_screen.dart';
import 'package:app/screen/video_player/video_player_device.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/recipe_list_widget.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

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
  List<TextEditingController> ingredientList = [TextEditingController()];
  List<FocusNode> ingredientFoucusNode = [FocusNode()];
  TextEditingController method = TextEditingController();
  TextEditingController chiefWhisper = TextEditingController();
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<CategoryData> categoryList = [];
  List<CategoryData> selectedCategoryIDList = [];
  bool isVideoUploading = false;
  File? recipeImage;
  File? recipeThumbnail;
  bool isVideo = false;
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
                    imagePickerPopUp(uploadType: 1);
                  },
                  child: recipeImage != null
                      ? isVideoUploading == true
                          ? Container(
                              height: MediaQuery.of(context).size.height * .35,
                              width: MediaQuery.of(context).size.width * 1,
                              alignment: Alignment.center,
                              color: ColorConstant.greyColor.withOpacity(0.4),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      duration: Duration(
                                          milliseconds: AppConstant
                                              .pageAnimationDuration),
                                      child: VideoPlayerDeviceScreen(
                                        videoPath: recipeImage!.path,
                                      ),
                                    ),
                                  );
                                },
                                child: const Center(
                                    child: Icon(
                                  Icons.play_circle_fill_sharp,
                                  color: ColorConstant.mainColor,
                                  size: 50,
                                )),
                              ),
                            )
                          : Container(
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
                          color: ColorConstant.greyColor.withOpacity(0.3),
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
                                "Upload Media",
                                style: TextStyle(
                                    color: ColorConstant.mainColor,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                ),
                if (isVideoUploading) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      imagePickerPopUp(uploadType: 2);
                    },
                    child: recipeThumbnail != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * .35,
                            width: MediaQuery.of(context).size.width * 1,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(recipeThumbnail!),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * .35,
                            width: MediaQuery.of(context).size.width * 1,
                            color: ColorConstant.greyColor.withOpacity(0.3),
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
                                  "Upload Thumbnail Image",
                                  style: TextStyle(
                                      color: ColorConstant.mainColor,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                  ),
                ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomSearchTextField(
                    borderRadius: 10,
                    onTap: () async {
                      await tagSelectBottomSheet();
                      setState(() {});
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    context: context,
                    hintText: 'Select Recipe Tag',
                  ),
                ),
                if (selectedCategoryIDList.isNotEmpty) ...[
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 4,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: selectedCategoryIDList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return categoryBox(
                            title: selectedCategoryIDList[index].name,
                            context: context);
                      },
                    ),
                  ),
                ],
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
                commonTextWidget(title: 'Ingredient List'),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ingredientList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${index + 1}. '),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: CustomSearchTextField(
                              isMaxLine: false,
                              focusNode: ingredientFoucusNode[index],
                              borderRadius: 10,
                              controller: ingredientList[index],
                              context: context,
                              hintText: 'Ingredient List',
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                if (ingredientList[index].text.isEmpty) {
                                  toastShow(
                                      message:
                                          "Please enter ingredient item then add list");
                                  return;
                                }
                                ingredientList.add(TextEditingController());
                                ingredientFoucusNode.add(FocusNode());

                                ingredientFoucusNode[
                                        ingredientFoucusNode.length - 1]
                                    .requestFocus();
                                setState(() {});
                              },
                              child: const Icon(Icons.add_circle))
                        ],
                      ),
                    );
                  },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonButton(
                        width: MediaQuery.of(context).size.width * .43,
                        color: ColorConstant.mainColor,
                        textColor: ColorConstant.white,
                        title: "Save",
                        onTap: () {
                          _createRecipe(3);
                        },
                      ),
                      CommonButton(
                        width: MediaQuery.of(context).size.width * .43,
                        color: ColorConstant.mainColor,
                        textColor: ColorConstant.white,
                        title: "Publish",
                        onTap: () {
                          _createRecipe(0);
                        },
                      ),
                    ],
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

  tagSelectBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Select Tag",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Divider(
                      color: Colors.grey.shade900,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .37,
                      child: ListView.builder(
                        itemCount: categoryList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    if (categoryList[index].isSelected ==
                                        false) {
                                      if (selectedCategoryIDList.length < 3) {
                                        categoryList[index].isSelected = true;
                                        selectedCategoryIDList
                                            .add(categoryList[index]);
                                      }
                                    } else {
                                      categoryList[index].isSelected = false;
                                      selectedCategoryIDList.removeWhere(
                                          (element) =>
                                              element.id ==
                                              categoryList[index].id);
                                    }
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        categoryList[index].isSelected == true
                                            ? Icons.check_box_outlined
                                            : Icons
                                                .check_box_outline_blank_outlined,
                                        color: categoryList[index].isSelected ==
                                                true
                                            ? ColorConstant.mainColor
                                            : Colors.grey.shade700,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        categoryList[index].name ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .015,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void imagePickerPopUp({int? uploadType}) async {
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromGallery(uploadType: uploadType);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .035),
                            alignment: Alignment.center,
                            child: const Text(
                              'Gallery',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromCamera(uploadType: uploadType);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .035),
                            alignment: Alignment.center,
                            child: const Text(
                              'Camera',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                        if (uploadType == 1) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(false);
                              selectVideoFromGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.mainColor,
                                  borderRadius: BorderRadius.circular(8)),
                              height: 35,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .035),
                              // width: MediaQuery.of(context).size.width * .2,
                              alignment: Alignment.center,
                              child: const Text(
                                'Video',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorConstant.white),
                              ),
                            ),
                          ),
                        ],
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

  void recipeUploadedPopUp() async {
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
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'SENT FOR APPROVAL',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.mainColor,
                        fontSize: 20,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Your recipe has been submitted for the approval by the admin, Once Approved it will be published on the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 12,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              duration: Duration(
                                  milliseconds:
                                      AppConstant.pageAnimationDuration),
                              child: const DashBoardScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstant.mainColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: const Text(
                          'Go Back To Home Page',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorConstant.white),
                        ),
                      ),
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

  imageFromCamera({int? uploadType}) async {
    try {
      final XFile? result =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (result != null) {
        _cropImage(imagePath: result.path, uploadType: uploadType);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  selectVideoFromGallery() async {
    try {
      setState(() {
        isLoading = true;
      });
      final XFile? result = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (result != null) {
        File dummyFile = File(result.path);
        int sizeInBytes = dummyFile.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 200) {
          isVideoUploading = false;
          recipeImage = null;
          toastShow(message: "Your selected video is above 200MB");
          return;
        }
        isVideoUploading = true;
        recipeImage = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  imageFromGallery({int? uploadType}) async {
    try {
      final XFile? result = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 60);
      if (result != null) {
        _cropImage(imagePath: result.path, uploadType: uploadType);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _cropImage({String? imagePath, int? uploadType}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ColorConstant.mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Image Crop',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      if (uploadType == 1) {
        recipeImage = File(croppedFile.path);
      } else {
        recipeThumbnail = File(croppedFile.path);
      }

      setState(() {});
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

  Future _createRecipe(status) async {
    if (recipeImage == null) {
      toastShow(message: "Please select recipe image");
      return;
    }
    if (isVideoUploading && recipeThumbnail == null) {
      toastShow(message: "Please select thumbnail image");
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
    if (ingredientList[0].text.isEmpty) {
      toastShow(message: "Please enter ingredient list");
      return;
    }
    if (method.text.isEmpty) {
      toastShow(message: "Please enter method");
      return;
    }

    String ingredientListString = "";
    for (int i = 0; i < ingredientList.length; i++) {
      if (ingredientList[i].text.isNotEmpty) {
        if (ingredientListString == "") {
          ingredientListString = ingredientList[i].text.trim();
        } else {
          ingredientListString =
              "$ingredientListString,${ingredientList[i].text.trim()}";
        }
      }
    }

    try {
      setState(() {
        isLoading = true;
      });
      List ids = [];
      for (int i = 0; i < selectedCategoryIDList.length; i++) {
        ids.add(selectedCategoryIDList[i].id);
      }
      FocusManager.instance.primaryFocus?.unfocus();

      RecipeCreateRes response = await RecipeRepository().createRecipeApiCall(
        categoryID: ids.toString().replaceAll('[', "").replaceAll(']', ""),
        chefWhisper: chiefWhisper.text.toString().trim(),
        chefWhisperTagline: "",
        cookingTime: cookingTime.text.trim(),
        description: discretion.text.trim(),
        ingredientList: ingredientListString,
        method: method.text.trim(),
        methodTagLine: "",
        preparationTime: preparationTime.text.trim(),
        recipeImage: recipeImage,
        recipeName: recipeName.text.trim(),
        servingPortion: severingPortion.text.trim(),
        tagLine: recipeTagLine.text.trim(),
        status: status,
        recipeThumbnail: recipeThumbnail,
      );
      if (response.success == true) {
        if (status == 0) {
          recipeUploadedPopUp();
        }
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
