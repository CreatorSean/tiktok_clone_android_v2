import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone_android/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone_android/features/authentication/login_screen.dart';
import 'package:tiktok_clone_android/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone_android/features/inbox/activity_screen.dart';
import 'package:tiktok_clone_android/features/inbox/chat_detail_scteen.dart';
import 'package:tiktok_clone_android/features/inbox/chats_screen.dart';
import 'package:tiktok_clone_android/features/onboarding/interests_screen.dart';

import 'features/videos/views/video_recording_screen.dart';

final router = GoRouter(
  initialLocation: "/inbox",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|discover|inbox|profile)",
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(
          tab: tab,
        );
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeURL,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: ChatScreen.routeName,
      path: ChatScreen.routeURL,
      builder: (context, state) => const ChatScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (context, state) {
            final chatId = state.params["chatId"]!;
            return ChatDetailScreen(chatId: chatId);
          },
        )
      ],
    ),
    GoRoute(
      name: VideoRecordingScreen.routeName,
      path: VideoRecordingScreen.routeURL,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 200),
        child: const VideoRecordingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
      ),
    ),
  ],
);




































// final router = GoRouter(
//   routes: [
//     GoRoute(
//       name: SignUpScreen.routeName,
//       path: SignUpScreen.routeURL,
//       builder: (context, state) => const SignUpScreen(),
//       routes: [
//         GoRoute(
//           path: UsernameScreen.routeURL,
//           name: UsernameScreen.routeName,
//           builder: (context, state) => const UsernameScreen(),
//           routes: [
//             GoRoute(
//               name: EmailScreen.routeName,
//               path: EmailScreen.routeURL,
//               builder: (context, state) {
//                 final args = state.extra as EmailScreenArgs;
//                 return EmailScreen(usernameStr: args.usernameStr);
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//     GoRoute(
//       path: "/users/:username",
//       builder: (context, state) {
//         final usernameStr = state.params['usernameStr'];
//         final tab = state.queryParams["show"];
//         return UserProfileScreen(
//           usernameStr: usernameStr!,
//           tab: tab!,
//         );
//       },
//     ),
//   ],
// );
  // routes: [
  //   //signUp_Screen
  //   GoRoute(
  //     name: SignUpScreen.routeName,
  //     path: SignUpScreen.routeURL,
  //     builder: (context, state) => const SignUpScreen(),
  //     routes: [
  //       GoRoute(
  //         name: UsernameScreen.routeName,
  //         path: UsernameScreen.routeURL,
  //         builder: (context, state) => const UsernameScreen(),
  //         routes: [
  //           GoRoute(
  //             name: EmailScreen.routeName,
  //             path: EmailScreen.routeURL,
  //             builder: (context, state) {
  //               final args = state.extra as EmailScreenArgs;
  //               return EmailScreen(usernameStr: args.usernameStr);
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
    //Login_Screen
    /* GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ), */
    //Username_Screen
    /* GoRoute(
      name: "username_screen",
      path: UsernameScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
    ), */
    //Email_Screen
    /* GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(usernameStr: args.usernameStr);
      },
    ), */
    //UserProfile_Screen

  // ],

