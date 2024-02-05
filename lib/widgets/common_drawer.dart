import 'package:app/screen/home_maker/home_maker_screen.dart';
import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstant.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              const Text(
                "EXPLORE MORE",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.organColor),
              ),
              const Text(
                "Manage, Explore, Create",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.greyColor),
              ),
              const SizedBox(
                height: 35,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.userSecret),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeMakerScreen(),
                    ),
                  );
                },
                title: "Meet The Homemakers",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.bellConcierge),
                onTap: () {},
                title: "Recipe Creation",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.bookOpen),
                onTap: () {},
                title: "My Plans",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.listCheck),
                onTap: () {},
                title: "My List",
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: ColorConstant.greyColor,
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.gear),
                onTap: () {},
                title: "Setting",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.robot),
                onTap: () {},
                title: "Ask AI",
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: ColorConstant.greyColor,
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.circleInfo),
                onTap: () {},
                title: "Help",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.circleQuestion),
                onTap: () {},
                title: "FAQs",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.heart),
                onTap: () {},
                title: "Follow Us",
              ),
              const SizedBox(
                height: 20,
              ),
              commonRaw(
                icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
                onTap: () {},
                title: "Log Out",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonRaw({FaIcon? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon!,
          const SizedBox(
            width: 15,
          ),
          Text(
            title!,
            style: const TextStyle(
                fontSize: 14,
                color: ColorConstant.black,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
