import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/view/screens/add_post/add_post.dart';
import 'package:social_media/view/screens/feed_screen/feed_screen.dart';
import 'package:social_media/view/screens/home_screen/home_screen.dart';
import 'package:social_media/view/screens/profile/profile_screen.dart';
import 'package:social_media/view/screens/search/search_screen.dart';
import 'package:social_media/widget/custome_icon.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, this.page});
  final int? page;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 2;

  // Populate the _widgetOptions list with actual screens
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const FeedScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_selectedIndex > 0) {
            setState(() {
              _selectedIndex = 0;
            });
            return false;
          } else {
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Do you want to close the app?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.end,
                  actions: [
                    TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
            return shouldPop ?? false;
          }
        },
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Resources.colors.whiteColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0
                      ? Resources.colors.themeColor
                      : Resources.colors.greyColor,
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  Icons.home,
                  size: 25,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1
                      ? Resources.colors.themeColor
                      : Resources.colors.greyColor,
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
              label: ""),
          // const BottomNavigationBarItem(
          //     // icon: ColorFiltered(
          //     //   colorFilter: ColorFilter.mode(
          //     //     _selectedIndex == 2
          //     //         ? Resources.colors.themeColor
          //     //         : Resources.colors.greyColor,
          //     //     BlendMode.srcIn,
          //     //   ),
          //     //   child: const CustomIcon(),
          //     // ),
          //     icon: CustomIcon(),
          //     label: ""),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2
                      ? Resources.colors.themeColor
                      : Resources.colors.greyColor,
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  Icons.movie_creation,
                  size: 25,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3
                      ? Resources.colors.themeColor
                      : Resources.colors.greyColor,
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  Icons.person,
                  size: 25,
                ),
              ),
              label: ""),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Resources.colors.themeColor,
        unselectedItemColor: Resources.colors.blackColor,
        iconSize: 20,
        unselectedLabelStyle: Resources.styles.kTextStyle12B(Colors.white),
        selectedLabelStyle: Resources.styles.kTextStyle12B(Colors.white),
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }
}
