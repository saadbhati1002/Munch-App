import 'package:app/screen/contest/participate/participate_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_button.dart';
import 'package:flutter/material.dart';

class ContestDetailScreen extends StatefulWidget {
  const ContestDetailScreen({super.key});

  @override
  State<ContestDetailScreen> createState() => _ContestDetailScreenState();
}

class _ContestDetailScreenState extends State<ContestDetailScreen> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "20 Participant",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Contest Name',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.mainColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "A recipe is a set of instructions that describes how to prepare or make something, especially a of prepared food. A sub-recipe or sub recipe is a recipe for an that will be called for in the instructions for the main recipe.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.black),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Rules',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.mainColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.greyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const Text(
                      '\u2022 1 cup quinoa',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.w400),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CommonButton(
                color: ColorConstant.mainColor,
                textColor: ColorConstant.white,
                title: "Participate",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ParticipateScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
