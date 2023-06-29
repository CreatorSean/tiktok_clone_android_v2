import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_android/constants/gaps.dart';
import 'package:tiktok_clone_android/features/discover/discover_screen.dart';
import 'package:tiktok_clone_android/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone_android/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone_android/features/main_navigation/widgets/post_video.button.dart';
import 'package:tiktok_clone_android/features/users/users_profile_screen.dart';
import 'package:tiktok_clone_android/features/utils.dart';

import '../../constants/sizes.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndexInt = 1;

  void _onTap(int indexInt) {
    setState(() {
      _selectedIndexInt = indexInt;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor:
          _selectedIndexInt == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndexInt != 0,
            //child: const VideoTimeLineScreen(),
          ),
          Offstage(
            offstage: _selectedIndexInt != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndexInt != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndexInt != 4,
            child: const UserProfileScreen(
              usernameStr: "시헌",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIndexInt == 0 || isDark ? Colors.black : Colors.white,
        padding: const EdgeInsets.only(
          bottom: Sizes.size32,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                textStr: 'Home',
                isSelected: _selectedIndexInt == 0,
                deselectIcon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndexInt,
              ),
              NavTab(
                textStr: 'Discover',
                isSelected: _selectedIndexInt == 1,
                deselectIcon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndexInt,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(isInverted: _selectedIndexInt != 0),
              ),
              Gaps.h24,
              NavTab(
                textStr: 'Inbox',
                isSelected: _selectedIndexInt == 3,
                deselectIcon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndexInt,
              ),
              NavTab(
                textStr: 'Profile',
                isSelected: _selectedIndexInt == 4,
                deselectIcon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndexInt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
