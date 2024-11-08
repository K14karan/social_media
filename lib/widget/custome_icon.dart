import 'package:flutter/material.dart';
import 'package:social_media/resources/resources.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF673AB7), // Updated color
              borderRadius: BorderRadius.circular(7),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF673AB7), // Updated color
              borderRadius: BorderRadius.circular(7),
            ),
          ),

          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: Resources.colors.whiteColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.add,
                color: Resources.colors.blackColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
