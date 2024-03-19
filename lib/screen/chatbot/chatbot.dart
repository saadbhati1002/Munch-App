import 'dart:convert';

import 'package:app/models/chatbot/chatbot_model.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/widgets/app_bar_title.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;
    String apiKey = "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";
    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
        var response = await Dio().post(
          "https://api.openai.com/v1/chat/completions",
          options: Options(
            headers: {
              "Authorization": "Bearer $apiKey",
              "Content-Type": "application/json"
            },
          ),
          data: jsonEncode(
            {
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": text}
              ]
            },
          ),
        );

        if (response.statusCode == 200) {
          var json = response.data;
          setState(() {
            isTyping = false;
            msgs.insert(
                0,
                Message(
                    false,
                    json["choices"][0]["message"]["content"]
                        .toString()
                        .trimLeft()));
          });
          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        }
      }
    } on Exception {
      toastShow(message: "Some error occurred, please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGroundColor,
      appBar: titleAppBar(
        context: context,
        title: "AI Chat",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          msgs.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: msgs.length,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: isTyping && index == 0
                            ? Column(
                                children: [
                                  BubbleNormal(
                                    text: msgs[0].msg,
                                    isSender: true,
                                    color: Colors.blue.shade100,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Typing...")),
                                  )
                                ],
                              )
                            : BubbleNormal(
                                text: msgs[index].msg,
                                isSender: msgs[index].isSender,
                                color: msgs[index].isSender
                                    ? Colors.blue.shade100
                                    : Colors.grey.shade200,
                              ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.robot,
                      color: ColorConstant.greyDarkColor,
                      size: 45,
                    ),
                  ),
                ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 7),
                            border: InputBorder.none,
                            hintText: "Enter text"),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: ColorConstant.mainColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ],
      ),
    );
  }
}
