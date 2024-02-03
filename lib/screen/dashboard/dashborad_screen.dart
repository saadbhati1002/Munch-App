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

  final _children = const [HomeScreen(), QuestionAndAnswerScreen()];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
