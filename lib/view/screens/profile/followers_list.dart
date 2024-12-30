import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FollowersListScreen extends StatefulWidget {
  final String userId;

  const FollowersListScreen({super.key, required this.userId});

  @override
  State<FollowersListScreen> createState() => _FollowersListScreenState();
}

class _FollowersListScreenState extends State<FollowersListScreen> {
  late AuthProvider authProvider;
  loadData(){
    authProvider=Provider.of<AuthProvider>(context,listen: false);


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
      appBar: AppBar(title: const Text("Followers")),
      // body: Consumer<AuthProvider>(
      //   builder: (context, userProvider, _) {
      //     return ListView.builder(
      //       itemCount: userProvider.providerId.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           title: Text(userProvider.followers[index]),
      //           subtitle: const Text('User ID'),
      //           trailing: IconButton(
      //             icon: Icon(Icons.remove_circle),
      //             onPressed: () async {
      //               // Unfollow user
      //            //   await userProvider.unfollowUser(widget.userId, userProvider.followers[index]);
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
