import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/router/routes_name.dart';
import 'package:social_media/view/auth/login_screen.dart';
import 'package:social_media/view/auth/navigation_screen.dart';
import 'package:social_media/view/auth/register_screen.dart';
import 'package:social_media/view/auth/splash_screen.dart';
import 'package:social_media/view/screens/add_post/add_post.dart';
import 'package:social_media/view/screens/chat/chat_list.dart';
import 'package:social_media/view/screens/chat/chat_screen.dart';
import 'package:social_media/view/screens/notification/notification_page.dart';
import 'package:social_media/view/screens/profile/edit_profile.dart';
import 'package:social_media/view/screens/search/search_screen.dart';
import 'package:social_media/view/screens/search/user_search_profile.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
      // navigatorKey: navigatorKey,
      routes: [
        GoRoute(
            name: RoutesName.splash,
            path: "/",
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            }),
        GoRoute(
            name: RoutesName.loginScreen,
            path: "/login_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            }),
        GoRoute(
            name: RoutesName.registerScreen,
            path: "/register_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            }),
        GoRoute(
            name: RoutesName.navigationScreen,
            path: "/navigation_screen",
            builder: (BuildContext context, GoRouterState state) {
              int? page = state.extra as int?;
              return NavigationScreen(page: page);
            }),
        GoRoute(
            name: RoutesName.searchScreen,
            path: "/search_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const SearchScreen();
            }),
        // GoRoute(
        //     name: RoutesName.userSearchScreen,
        //     path: "/user_search_profile",
        //     builder: (BuildContext context, GoRouterState state) {
        //       final user = state.extra as User;
        //       return  UserProfilePage(user: user);
        //     }),
        GoRoute(
            name: RoutesName.chatList,
            path: "/chat_list",
            builder: (BuildContext context, GoRouterState state) {
              //return const ChatList();
              return const ChatList();
            }),
        // GoRoute(
        //     name: RoutesName.chatScreen,
        //     path: "/chat_screen",
        //     builder: (BuildContext context, GoRouterState state) {
        //      var chatId = state.extra as String ?? '';
        //       return  ChatScreen( );
        //     }),
        GoRoute(
            name: RoutesName.notificationScreen,
            path: "/notification_page",
            builder: (BuildContext context, GoRouterState state) {
              return const NotificationPage();
            }),
        GoRoute(
            name: RoutesName.addPostScreen,
            path: "/add_post",
            builder: (BuildContext context, GoRouterState state) {
              return const AddPost();
            }),
        GoRoute(
            name: RoutesName.editProfileScreen,
            path: "/edit_profile",
            builder: (BuildContext context, GoRouterState state) {
              return const EditProfile();
            }),
      ],
      errorBuilder: (context, state) {
        return Text(state.error.toString());
      });
}
