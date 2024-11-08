import 'package:flutter/material.dart';
import 'package:social_media/resources/resources.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({
    super.key,
  });

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                                "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202209/meglanning_1200x768.jpeg?VersionId=FBiIKfIadFiqO0DcBpHmUvPwNiuj4IZB&size=690:388"),
                          ),
                          title: Row(
                            children: [
                              Text(
                                "Pankaj ",
                                style: Resources.styles
                                    .kTextStyle14B(Resources.colors.blackColor),
                              ),
                              Text(
                                "nice",
                                style: Resources.styles
                                    .kTextStyle14B(Resources.colors.greyColor),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "1 Apr 2021",
                                style: Resources.styles
                                    .kTextStyle14(Resources.colors.blackColor),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '250 likes',
                                style: Resources.styles
                                    .kTextStyle12(Resources.colors.blackColor),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {},
                            child: Icon(Icons.favorite,
                                size: 20, color: Colors.red),
                          ),
                        );
                      })),
              const Divider(),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextFormField(
                    controller: _commentController,
                    style: Resources.styles
                        .kTextStyle16(Resources.colors.blackColor),
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    backgroundColor: Resources.colors.themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Resources.colors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
