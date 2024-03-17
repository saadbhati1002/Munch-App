import 'package:app/api/repository/membership/membership.dart';
import 'package:app/models/membership/my_membership/my_membership_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_back.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMembershipScreen extends StatefulWidget {
  const MyMembershipScreen({super.key});

  @override
  State<MyMembershipScreen> createState() => _MyMembershipScreenState();
}

class _MyMembershipScreenState extends State<MyMembershipScreen> {
  bool isLoading = false;
  List<MyMembershipData> membershipList = [];
  @override
  void initState() {
    _getMyMemberships();
    super.initState();
  }

  Future _getMyMemberships() async {
    try {
      setState(() {
        isLoading = true;
      });
      MyMembershipRes response =
          await MembershipRepository().getMyMembershipApiCall();
      if (response.data != null) {
        membershipList = response.data!;
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
      body: isLoading
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const CommonSkeleton();
              },
            )
          : membershipList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  itemCount: membershipList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return membershipWidget(
                        membershipData: membershipList[index]);
                  },
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * 1,
                  child: const Center(
                    child: Text(
                      "No Membership Payment Found",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
    );
  }

  Widget membershipWidget({MyMembershipData? membershipData}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: ColorConstant.greyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(membershipData!.planName!),
              ),
              Text(
                "AED ${membershipData.planAmount!}",
                style: const TextStyle(color: ColorConstant.organColor),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(membershipData.createdAt!))
              .toString())
        ],
      ),
    );
  }
}
