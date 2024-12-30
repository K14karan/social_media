import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FollowingListScreen extends StatefulWidget {
  final String userId;

  FollowingListScreen({required this.userId});

  @override
  State<FollowingListScreen> createState() => _FollowingListScreenState();
}

class _FollowingListScreenState extends State<FollowingListScreen> {
  late AuthProvider authProvider;
  loadData(){
    authProvider=Provider.of<AuthProvider>(context,listen: false);
   // authProvider.fetchFollowingList(widget.userId);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    authProvider=Provider.of<AuthProvider>(context,);
    return Scaffold(
      appBar: AppBar(title: Text("Following")),
      // body: Consumer<AuthProvider>(
      //   builder: (context, userProvider, _) {
      //     return ListView.builder(
      //       itemCount: userProvider._following.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           title: Text(userProvider._following[index]),
      //           subtitle: Text('User ID'),
      //           trailing: IconButton(
      //             icon: Icon(Icons.remove_circle),
      //             onPressed: () async {
      //               // Unfollow user
      //             //  await userProvider.unfollowUser(widget.userId, userProvider.following[index]);
      //             },
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
