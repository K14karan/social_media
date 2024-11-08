import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/view/screens/search/user_search_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                cursorColor: Resources.colors.themeColor,

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  labelText: 'Search',
                  labelStyle: Resources.styles.kTextStyle14B(Colors.grey),
                  hintText: 'Type a name...',
                  hintStyle: Resources.styles.kTextStyle14B(Colors.grey),
                  filled: true,
                  fillColor: Resources.colors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Resources.colors.themeColor,
                      width: .5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Resources.colors.themeColor,
                      width: .5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Resources.colors.themeColor,
                      width: .5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Resources.colors.themeColor,
                      width: .5,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      userProvider.searchUsers(searchController.text);
                    },
                  ),
                ),
                onChanged: (value) {
                  userProvider.searchUsers(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userProvider.filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = userProvider.filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(user.profilePicture),
                    ),
                    title: Text(
                      user.name,
                      style: Resources.styles.kTextStyle14B(Resources.colors.greyColor),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        userProvider.followUser(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Followed ${user.name}')),
                        );
                      },
                      child: Text(
                        'Follow',
                        style: Resources.styles.kTextStyle14B(Resources.colors.themeColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(user: user),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
