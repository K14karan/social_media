import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/provider/add_post_controller.dart';
import 'package:social_media/provider/add_story_provider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes.dart';
import 'package:social_media/services/app_checker.dart';
import 'package:social_media/services/constant.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ZIMKit().init(
    appID: Constants.appId,
    appSign: Constants.appSign,
  );

  await initializeAppCheck();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers for state management
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AddPostController()),
         ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp.router(
        title: 'ConnectMe',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Resources.colors.themeColor),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
//SHA1=>0E:CD:48:45:B5:D2:A7:42:F4:6D:84:DF:F8:1C:41:EF:FB:2A:53:58
//SHA256=>01:00:11:D3:23:5E:A8:73:24:13:47:29:D4:E4:4C:8F:71:62:30:04:FB:F6:C2:A6:BE:79:EE:97:0D:C2:07:85
//token=>A148E4E1-45C4-4DD0-BCDB-D832EBE9C7C2
