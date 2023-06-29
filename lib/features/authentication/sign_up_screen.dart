import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone_android/features/authentication/username_screen.dart';
import 'package:tiktok_clone_android/features/utils.dart';

import '../../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'login_screen.dart';
import 'widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  static const routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});
  final tDuration = const Duration(seconds: 1);
  final rDuration = const Duration(seconds: 1);

  void _onLoginTap(BuildContext context) async {
    context.push(LoginScreen.routeName);
    //push a location onto the page stack => 이전 화면 위에 다른 화면을 올림
  }

  void _onEmailTap(BuildContext context) {
    context.pushNamed(UsernameScreen.routeName);
    //context.go는 이전 화면 위에 다른 화면을 올리는 것이 아님

    /* Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: tDuration,
        reverseTransitionDuration: rDuration,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          );
          final opacityAnimation = Tween(
            begin: 0.5,
            end: 0.5,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation.animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    ); */
  }

  void onAppleTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text(
        //         'Plz rotate ur phone.',
        //       ),
        //     ),
        //   );
        // }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    'Sign up for TikTok',
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.6,
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        'Create a profile, follow other accounts, make your own videos, and more.',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: const AuthButton(
                        // createPage: ,
                        icon: FaIcon(FontAwesomeIcons.user),
                        text: "Use phone or email",
                      ),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => onAppleTap(context),
                      child: const AuthButton(
                        icon: FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Apple",
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: const AuthButton(
                              // createPage: ,
                              icon: FaIcon(FontAwesomeIcons.user),
                              text: "Use phone or email",
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => onAppleTap(context),
                            child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Apple",
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
