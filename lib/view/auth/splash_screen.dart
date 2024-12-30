import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigethome();
  }

  _navigethome() async {
    // Delay for splash screen
    await Future.delayed(const Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      log("uid:$uid");

      // Navigate to appropriate screen
      if (uid != null) {
        GoRouter.of(context).pushReplacementNamed(RoutesName.navigationScreen);
      } else {
        GoRouter.of(context).pushReplacementNamed(RoutesName.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Resources.colors.themeColor,
      ),
    );
  }
}
