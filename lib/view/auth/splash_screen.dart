import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    // TODO: implement initState
    super.initState();
    _navigethome();
  }
  _navigethome() async {
    await Future.delayed(const Duration(seconds: 4), () {
      GoRouter.of(context).pushReplacementNamed(RoutesName.loginScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    const text = "vaktaa";
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
