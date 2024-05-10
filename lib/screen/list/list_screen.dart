import 'dart:async';

import 'package:app/api/repository/list/list.dart';
import 'package:app/models/common_model.dart';
import 'package:app/models/list/add/add_list_model.dart';
import 'package:app/models/list/list_model.dart';
import 'package:app/screen/list/add/add_list_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:app/widgets/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListData> dataList = [];
  bool isLoading = false;
  bool isApiLoading = false;
  Timer? _debounce;
  String? searchedName;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future _getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      ListRes response = await ListRepository().getListApiCall();
      if (response.data != null) {
        dataList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        searchedName = query;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Your List',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.organColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var response = await Get.to(
                            () => const AddListScreen(),
                          );
                          if (response != null) {
                            _getData();
                          }
                        },
                        child: Container(
                          height: 37,
                          decoration: BoxDecoration(
                            color: ColorConstant.mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Create List",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSearchTextField(
                    onChanged: _onSearchChanged,
                    context: context,
                    hintText: 'Search for Recipe',
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
                    ? dataList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searchedName == null || searchedName == ""
                                  ? savedListWidget(
                                      data: dataList[index], index: index)
                                  : searchedName!
                                          .contains(dataList[index].recipeName!)
                                      ? savedListWidget(
                                          data: dataList[index], index: index)
                                      : const SizedBox();
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .45,
                            width: MediaQuery.of(context).size.width * 1,
                            child: const Center(
                              child: Text(
                                "No Saved List Found",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorConstant.greyColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return listSkeleton();
                        },
                      )
              ],
            ),
          ),
          isApiLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  Widget savedListWidget({ListData? data, int? index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: ColorConstant.greyColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Text(
                      data!.recipeName ?? '',
                      style: const TextStyle(
                          fontSize: 14,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _removeFromList(index: index);
                    },
                    child: const Icon(
                      Icons.cancel,
                      size: 28,
                      color: ColorConstant.mainColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                height: 30,
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                  color: ColorConstant.greyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Serves: ${data.servingPortion} Portions",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1,
                      fontSize: 13,
                      color: ColorConstant.mainColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.ingredient!.length,
                itemBuilder: (context, ind) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (data.buyList![ind].toString().trim() == "0") {
                                data.buyList![ind] = "1";
                              } else {
                                data.buyList![ind] = "0";
                              }

                              _updateList(index);
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: ColorConstant.greyColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: data.buyList![ind].toString().trim() == "1"
                                  ? const Icon(
                                      Icons.check,
                                      size: 17,
                                      color: ColorConstant.mainColor,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .82,
                            child: Text(
                              data.ingredient![ind].trim(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorConstant.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget listSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: ColorConstant.mainColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 18,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 25,
                          height: 25,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  ListView.builder(
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01,
                        ),
                        child: Row(
                          children: [
                            const SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 22,
                                maxWidth: 22,
                                maxHeight: 22,
                                height: 22,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 15,
                                randomLength: true,
                                borderRadius: BorderRadius.circular(10),
                                maxLength:
                                    MediaQuery.of(context).size.width * .75,
                                width: MediaQuery.of(context).size.width * .75,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _updateList(
    index,
  ) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      AddListRes response = await ListRepository().editListApiCall(
          ingredient: dataList[index]
              .ingredient!
              .toString()
              .trim()
              .replaceAll("[", "")
              .replaceAll("]", ""),
          recipeName: dataList[index].recipeName!,
          servingPortion: dataList[index].servingPortion!,
          listID: dataList[index].id!,
          buy: dataList[index]
              .buyList!
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""));
      if (response.success == true) {
      } else {
        toastShow(message: response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }

  Future _removeFromList({int? index}) async {
    try {
      setState(() {
        isApiLoading = true;
      });
      CommonRes response = await ListRepository()
          .removeListApiCall(id: dataList[index!].id.toString());
      if (response.success == true) {
        dataList.removeAt(index);
        toastShow(message: "Removed from list.");
      } else {
        toastShow(message: "Please try again later");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }
}
