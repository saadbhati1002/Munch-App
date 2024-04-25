import 'package:app/api/repository/common/common.dart';
import 'package:app/models/faq/faq_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:app/widgets/common_skeleton.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool isLoading = false;
  List<FAQData> faqList = [];
  int? faqNumber;
  @override
  void initState() {
    _getFaq();
    super.initState();
  }

  Future _getFaq() async {
    try {
      setState(() {
        isLoading = true;
      });
      FAQRes response = await CommonRepository().getFAQApiCall();
      if (response.data!.isNotEmpty) {
        faqList = response.data!;
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
      appBar: titleAppBar(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
        title: "FAQs",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const CommonSkeleton();
                    },
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: faqList.length,
                    itemBuilder: (context, index) {
                      return faqWidget(index: index);
                    },
                  )
          ],
        ),
      ),
    );
  }

  Widget faqWidget({int? index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 2,
            child: GestureDetector(
              onTap: () {
                if (faqNumber == index) {
                  faqNumber = null;
                } else {
                  faqNumber = index;
                }
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: faqNumber == index
                      ? ColorConstant.mainColor
                      : ColorConstant.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  faqList[index!].question ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    color: faqNumber == index
                        ? ColorConstant.white
                        : ColorConstant.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: faqNumber == index ? 10 : 0,
          ),
          faqNumber == index
              ? Text(
                  faqList[index].text ?? "",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
