// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:social_media/resources/resources.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:async';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({
//     super.key,
//   });
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final List<Map<String, dynamic>> messages = [
//     {'sender': 'me', 'text': 'Hey, how are you?'},
//     {'sender': 'Ram Varma', 'text': 'I am good! What about you?'},
//     {'sender': 'me', 'text': 'Just working on some projects.'},
//     {'sender': 'Ram Varma', 'text': 'That sounds interesting!'},
//   ];
//
//   final TextEditingController _controller = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   final ScrollController _scrollController = ScrollController();
//
//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       // Add the image message to the messages list
//       setState(() {
//         messages.add({'sender': 'me', 'image': File(image.path)});
//         _scrollToBottom();
//       });
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       }
//     });
//   }
//
//   void _viewImage(File image) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ImageViewScreen(image: image),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Ram Varma',
//           style: Resources.styles.kTextStyle14B(Colors.black),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.video_call_outlined,
//               color: Resources.colors.themeColor,
//               size: 20,
//             ),
//             onPressed: () {},
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: IconButton(
//               icon: Icon(
//                 Icons.call,
//                 size: 20,
//                 color: Resources.colors.themeColor,
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 final isMe = message['sender'] == 'me';
//                 return Align(
//                   alignment:
//                       isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: message['text'] != null
//                       ? Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 10),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: isMe
//                                 ? Resources.colors.themeColor
//                                 : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             message['text']!,
//                             style: TextStyle(
//                                 color: isMe ? Colors.white : Colors.black),
//                           ),
//                         )
//                       : GestureDetector(
//                           onTap: () => _viewImage(message['image']),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               right: 10.0,
//                               top: 5.0,
//                             ),
//                             child: Image.file(
//                               message['image'],
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon:
//                 Icon(Icons.image, color: Resources.colors.themeColor, size: 25),
//             onPressed: _pickImage,
//           ),
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide.none,
//                 ),
//                 fillColor: Colors.grey[200],
//                 filled: true,
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               ),
//             ),
//           ),
//           IconButton(
//             icon:
//                 Icon(Icons.emoji_emotions, color: Resources.colors.themeColor),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.send, color: Resources.colors.themeColor),
//             onPressed: () {
//               if (_controller.text.isNotEmpty) {
//                 setState(() {
//                   messages.add({'sender': 'me', 'text': _controller.text});
//                   _controller.clear();
//                   _scrollToBottom();
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ImageViewScreen extends StatelessWidget {
//   final File image;
//
//   const ImageViewScreen({super.key, required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           children: [
//             Image.file(
//               image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//             Positioned(
//               bottom: 40,
//               left: 20,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await _downloadImage(image);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                 ),
//                 child: const Text('Download'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _downloadImage(File image) async {
//     try {
//       final directory = await getExternalStorageDirectory();
//       final String path = '${directory!.path}/${image.path.split('/').last}';
//       await image.copy(path);
//       Fluttertoast.showToast(
//         msg: "Image downloaded to $path",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Error downloading image: $e",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.userId,
      required this.name,
      required this.image});
  final String userId;
  final String name;
  final String image;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    ZIMKit().connectUser(id: widget.userId, name: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Chats',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Search functionality
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ZIMKit().showDefaultNewPeerChatDialog(context);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.chat, color: Colors.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: ZIMKitConversationListView(
                itemBuilder: (context, conversation, defaultWidget) {
                  return _buildConversationTile(conversation, defaultWidget);
                },
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
          ],
        ),
      ),
    );
  }

  Widget _buildConversationTile(
      ZIMKitConversation conversation, Widget defaultWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 23,
          backgroundImage: NetworkImage(widget.image),
        ),
        title: Text(
          conversation.name ?? 'Unknown',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          conversation.lastMessage?.textContent?.text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        onTap: () {
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
    );
  }
}
