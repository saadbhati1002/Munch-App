import 'dart:io';

import 'package:app/screen/Favorite/Favorite_screen.dart';
import 'package:app/screen/contest/contest_list/contest_list_screen.dart';
import 'package:app/screen/home/home_screen.dart';
import 'package:app/screen/q_and_a/q_and_a_list/q_and_a_screen.dart';
import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  final _children = const [
    HomeScreen(),
    QuestionAndAnswerScreen(),
    ContestListScreen(),
    FavoriteScreen(),
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> willPopScope() {
    appClosePopUp();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        extendBody: true,
        body: _children[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 65,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTapped,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white.withOpacity(0.95),
            unselectedItemColor: ColorConstant.greyColor,
            selectedItemColor: ColorConstant.mainColor,
            selectedLabelStyle: const TextStyle(
                fontFamily: "inter",
                fontWeight: FontWeight.w700,
                color: ColorConstant.mainColor,
                fontSize: 12),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: ColorConstant.greyColor,
                fontSize: 12),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.room_service,
                    color: _currentIndex == 0
                        ? ColorConstant.mainColor
                        : ColorConstant.greyColor,
                    size: 30,
                  ),
                  label: "Your Page"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_fire_department_outlined,
                    color: _currentIndex == 1
                        ? ColorConstant.mainColor
                        : ColorConstant.greyColor,
                    size: 30,
                  ),
                  label: "Q&A"),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank_outlined,
                  color: _currentIndex == 2
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor,
                  size: 30,
                ),
                label: "Contest",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _currentIndex == 3
                        ? ColorConstant.mainColor
                        : ColorConstant.greyColor,
                    size: 30,
                  ),
                  label: "Saved"),
            ],
          ),
        ),
      ),
    );
  }

  void appClosePopUp() async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: ColorConstant.greyColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  )),
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
                      'Are you sure?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'Do you want to close this app?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 14,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.white),
                              ),
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
}
