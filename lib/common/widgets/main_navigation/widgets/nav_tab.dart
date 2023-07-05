import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_android/features/utils.dart';

import '../../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.textStr,
    required this.isSelected,
    required this.onTap,
    required this.deselectIcon,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final String textStr;
  final bool isSelected;
  final IconData deselectIcon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: selectedIndex == 0 || isDark ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : deselectIcon,
                  color: selectedIndex == 0 || isDark
                      ? Colors.white
                      : Colors.black,
                ),
                Gaps.v5,
                Text(
                  textStr,
                  style: TextStyle(
                    color: selectedIndex == 0 || isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
