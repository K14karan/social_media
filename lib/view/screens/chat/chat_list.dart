// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_media/resources/resources.dart';
// import 'package:social_media/router/routes_name.dart';
//
//
// class ChatList extends StatefulWidget {
//   const ChatList({super.key});
//
//   @override
//   State<ChatList> createState() => _ChatListState();
// }
//
// class _ChatListState extends State<ChatList> {
//   // Sample data for chat list
//   final List<Map<String, dynamic>> chats = [
//     {
//       'name': 'John Doe',
//       'lastMessage': 'Hey! How are you?',
//       'time': '10:30 AM',
//       'avatarUrl':
//           'https://img.freepik.com/free-photo/medium-shot-boy-relaxing-nature_23-2150753072.jpg'
//     },
//     {
//       'name': 'Jane Smith',
//       'lastMessage': 'Are we still on for lunch?',
//       'time': '9:15 AM',
//       'avatarUrl':
//           'https://media.istockphoto.com/id/497000834/photo/little-asian-boy.jpg?s=612x612&w=0&k=20&c=bMs3BE39UAVO-ocjTfvLKD8Aq2YEM6TB2cH3xPUS_JM='
//     },
//     {
//       'name': 'Alice Johnson',
//       'lastMessage': 'Thanks for the update!',
//       'time': 'Yesterday',
//       'avatarUrl':
//           'https://img.freepik.com/free-photo/happy-boy-with-adorable-smile_23-2149352352.jpg?semt=ais_hybrid'
//     },
//     {
//       'name': 'Bob Brown',
//       'lastMessage': 'See you soon!',
//       'time': 'Yesterday',
//       'avatarUrl':
//           'https://media.gettyimages.com/id/1257773462/photo/1960s-portrait-bright-eyed-african-american-boy-blue-button-down-shirt-directly-looking-at.jpg?s=612x612&w=gi&k=20&c=hoQ7CYiACYM0Vej_Kvm0P3bvHhLu1-7u2zeK3c58rW8='
//     },
//   ];
//
//   String searchQuery = '';
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter the chat list based on the search query
//     final filteredChats = chats.where((chat) {
//       final nameLower = chat['name'].toLowerCase();
//       final queryLower = searchQuery.toLowerCase();
//       return nameLower.contains(queryLower);
//     }).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Chats',
//           style: Resources.styles.kTextStyle14B(Colors.black),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 showSearch(
//                     context: context, delegate: ChatSearchDelegate(chats));
//               },
//             ),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: filteredChats.length,
//         itemBuilder: (context, index) {
//           final chat = filteredChats[index];
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 22,
//               backgroundImage: NetworkImage(chat['avatarUrl']),
//             ),
//             title: Text(
//               chat['name'],
//               style:
//                   Resources.styles.kTextStyle14B(Resources.colors.blackColor),
//             ),
//             subtitle: Text(
//               chat['lastMessage'],
//               style: Resources.styles.kTextStyle12B(Resources.colors.greyColor),
//             ),
//             trailing: Text(
//               chat['time'],
//               style: Resources.styles.kTextStyle12B(Resources.colors.greyColor),
//             ),
//             onTap: () {
//               GoRouter.of(context).pushNamed(RoutesName.chatScreen);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ChatSearchDelegate extends SearchDelegate<String?> {
//   final List<Map<String, dynamic>> chats;
//
//   ChatSearchDelegate(this.chats);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.black,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     final filteredChats = chats.where((chat) {
//       return chat['name'].toLowerCase().contains(query.toLowerCase());
//     }).toList();
//
//     return ListView.builder(
//       itemCount: filteredChats.length,
//       itemBuilder: (context, index) {
//         final chat = filteredChats[index];
//         return ListTile(
//           leading: CircleAvatar(
//             radius: 22,
//             backgroundImage: NetworkImage(chat['avatarUrl']),
//           ),
//           title: Text( chat['name'],
//             style: Resources.styles
//                 .kTextStyle14B(Resources.colors.blackColor),
//           ),
//           subtitle: Text(
//             chat['lastMessage'],
//             style: Resources.styles
//                 .kTextStyle12B(Resources.colors.greyColor),
//           ),
//           onTap: () {
//             // Navigate to the chat screen (pass chat info if needed)
//             GoRouter.of(context).pushNamed(RoutesName.chatScreen);
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final filteredChats = chats.where((chat) {
//       return chat['name'].toLowerCase().contains(query.toLowerCase());
//     }).toList();
//
//     return ListView.builder(
//       itemCount: filteredChats.length,
//       itemBuilder: (context, index) {
//         final chat = filteredChats[index];
//         return ListTile(
//           leading: CircleAvatar(
//             radius: 22,
//             backgroundImage: NetworkImage(chat['avatarUrl']),
//           ),
//           title: Text(
//             chat['name'],
//             style: Resources.styles.kTextStyle14B(Resources.colors.blackColor),
//           ),
//           subtitle: Text(
//             chat['lastMessage'],
//             style: Resources.styles.kTextStyle12B(Resources.colors.greyColor),
//           ),
//           onTap: () {
//             GoRouter.of(context).pushNamed(RoutesName.chatScreen);
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          actions: const [],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          ZIMKit().showDefaultNewPeerChatDialog(context);
        }),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
