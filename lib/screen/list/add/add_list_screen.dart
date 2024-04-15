import 'package:app/api/repository/list/list.dart';
import 'package:app/models/list/add/add_list_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> ingredientList = [TextEditingController()];
  List buy = ["0"];
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
                    'Create List',
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
                    controller: recipeNameController,
                    context: context,
                    borderRadius: 10,
                    hintText: "Recipe Name",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    controller: portionController,
                    context: context,
                    borderRadius: 10,
                    keyboardType: TextInputType.number,
                    isMaxLine: false,
                    hintText: "Serving Portion",
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                              borderRadius: 10,
                              controller: ingredientList[index],
                              context: context,
                              hintText: 'Ingredient List',
                            ),
                          ),
                          index == ingredientList.length - 1
                              ? GestureDetector(
                                  onTap: () {
                                    if (ingredientList[index].text.isEmpty) {
                                      toastShow(
                                          message:
                                              "Please enter ingredient item then add list");
                                      return;
                                    }
                                    ingredientList.add(TextEditingController());
                                    buy.insert(0, "0");
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.add_circle),
                                )
                              : const SizedBox(
                                  width: 20,
                                )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonButton(
                    color: ColorConstant.mainColor,
                    textColor: ColorConstant.white,
                    title: "Create",
                    onTap: () {
                      _addList();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Future _addList() async {
    if (recipeNameController.text.isEmpty) {
      toastShow(message: "Please enter recipe name");
      return;
    }
    if (portionController.text.isEmpty) {
      toastShow(message: "Please enter serving portion");
      return;
    }
    if (ingredientList[0].text.isEmpty) {
      toastShow(message: "Please enter ingredient list");
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
      AddListRes response = await ListRepository().addListApiCall(
          ingredient: ingredientListString,
          recipeName: recipeNameController.text.trim(),
          servingPortion: portionController.text.trim(),
          buy: buy.toString().replaceAll("[", "").replaceAll("]", ""));
      if (response.success == true) {
        toastShow(message: "List created successfully");
        Get.back(result: "1");
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
