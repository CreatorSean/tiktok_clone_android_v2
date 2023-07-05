import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_android/features/utils.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();
  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _startWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDark ? null : Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            "22796 comments",
          ),
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            )
          ],
        ),
        body: GestureDetector(
          onTap: _onStopWriting,
          child: Stack(
            children: [
              Scrollbar(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    top: Sizes.size10,
                    right: Sizes.size16,
                    bottom: Sizes.size96 + Sizes.size10,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/108929080?v=4",
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '시헌',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              "That is not it l've seen the same thing but also in a cave.",
                              style: TextStyle(
                                color: isDark
                                    ? Colors.grey.shade500
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v2,
                          Text(
                            '52.2K',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size10,
                      bottom: Sizes.size32,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isDark ? Colors.grey.shade500 : null,
                          child: const Text("시헌"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _startWriting,
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    //mainAxisSize: 필요한 만큼만 공간을 사용해라.
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _onStopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                hintText: "Add comment...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size12,
                                    vertical: Sizes.size10),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
