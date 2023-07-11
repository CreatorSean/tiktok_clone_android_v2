import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone_android/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok_clone_android/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone_android/firebase_options.dart';
import 'package:tiktok_clone_android/router.dart';
import 'constants/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  //sharedpreferences에 접근
  final preferences = await SharedPreferences.getInstance();
  //initialize Repository
  //repository에 접근하려면 preferences가 필요하기 때문에 이 class의 preferences를 매개변수로 넘겨줌
  final repository = VideoPlaybackConfigRepository(preferences);
  runApp(
    ProviderScope(
      overrides: [
        //원래 playbackConfigViewModel에서 provider를 생성해야하는데 repository를 매개변수로 사용할 수 없었음.
        //그래서 unimplementedError를 throw했고 여기서sharedpreferences의 preferences를 사용하기 위해 providerscope의 overrides로 그 문제를 해결함
        //(SharedPreferences는 main에서 await해야함)
        //그래서 playbackConfigProvider에 playbackConfigViewModel에 repository를 매개변수로 해서 override한것임.
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        )
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: Typography.blackCupertino,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
          selectionColor: Color(0xFFE9435A),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16 + Sizes.size2,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography.whiteMountainView,
        primaryColor: const Color(0xFFE9435A),
        brightness: Brightness.dark,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
          selectionColor: Color(0xFFE9435A),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16 + Sizes.size2,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}

// class LayoutBuilderCodeLab extends StatelessWidget {
//   const LayoutBuilderCodeLab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) => Container(
//           width: constraints.maxWidth,
//           height: constraints.maxHeight,
//           color: Colors.teal,
//           child: Center(
//             child: Text(
//               "${size.width} / ${constraints.maxWidth}",
//               style: const TextStyle(color: Colors.white, fontSize: 98),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
