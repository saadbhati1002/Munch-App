import 'dart:async';
import 'dart:convert';

import 'package:app/api/repository/contest/contest.dart';
import 'package:app/models/contest/contest_model.dart';
import 'package:app/screen/contest/contest_detail/contest_detail_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/common_drawer.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:app/widgets/contest_list_widget.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContestListScreen extends StatefulWidget {
  const ContestListScreen({super.key});

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<ContestData> contestList = [];
  bool isLoading = false;
  bool isApiLoading = false;
  Timer? _debounce;
  String? searchedName;
  @override
  void initState() {
    _getQuestionList();
    super.initState();
  }

  _getQuestionList() async {
    try {
      setState(() {
        isLoading = true;
      });
      ContestRes response = await ContestRepository().getContestApiCall();
      if (response.data!.isNotEmpty) {
        setState(() {
          contestList = response.data!;
        });
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomSearchTextField(
                context: context,
                hintText: 'Search for contest',
                onChanged: _onSearchChanged,
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
            isLoading == false
                ? contestList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: contestList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              var response = await Get.to(
                                () => ContestDetailScreen(
                                  contestData: contestList[index],
                                ),
                              );
                              if (response != null) {
                                ContestData responseData =
                                    ContestData.fromJson(jsonDecode(response));
                                contestList[index].numOfParticipate =
                                    responseData.numOfParticipate;
                              }
                            },
                            child: contestListWidget(
                              contestData: contestList[index],
                              context: context,
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .45,
                        width: MediaQuery.of(context).size.width * 1,
                        child: const Center(
                          child: Text(
                            "No Contest Found",
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
                      return const CommonSkeleton();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
