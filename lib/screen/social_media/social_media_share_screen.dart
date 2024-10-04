import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaShareScreen extends StatefulWidget {
  const SocialMediaShareScreen({super.key});

  @override
  State<SocialMediaShareScreen> createState() => _SocialMediaShareScreenState();
}

class _SocialMediaShareScreenState extends State<SocialMediaShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: titleAppBar(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
        title: "Follow Us",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'You can contact us on all this platforms.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: ColorConstant.white,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialMediaWidget(
                      image: Images.facebook,
                      onTap: () {
                        launchUrl(
                          Uri.parse(AppConstant.facebookUrl),
                        );
                      },
                      title: 'Facebook',
                    ),
                    socialMediaWidget(
                      image: Images.instagram,
                      onTap: () {
                        launchUrl(
                          Uri.parse(AppConstant.instagramUrl),
                        );
                      },
                      title: 'Instagram',
                    ),
                    socialMediaWidget(
                      image: Images.whatsApp,
                      onTap: () {
                        launchUrl(
                          Uri.parse(AppConstant.whatsAppUrl),
                        );
                      },
                      title: 'Whatsapp',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialMediaWidget(
                      image: Images.youtube,
                      onTap: () {
                        launchUrl(
                          Uri.parse(AppConstant.youTubeUrl),
                        );
                      },
                      title: 'Youtube',
                    ),
                    socialMediaWidget(
                      image: Images.email,
                      onTap: () {
                        final Uri params = Uri(
                            scheme: 'mailto',
                            path: AppConstant.emailAddress,
                            queryParameters: {
                              'subject': 'Default Subject',
                              'body': 'Default body'
                            });
                        String url = params.toString();
                        launchUrl(
                          Uri.parse(url),
                        );
                      },
                      title: 'Email',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(Images.social)
        ],
      ),
    );
  }

  Widget socialMediaWidget(
      {String? image, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 34,
            width: 34,
            child: Image.asset(image!),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
