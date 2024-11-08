import 'package:flutter/material.dart';
import 'package:social_media/resources/resources.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Resources.colors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadowColor: Colors.black45,
              elevation: 5,
            ),
            child: Text(
              'Register',
              style: Resources.styles
                  .kTextStyle16B(Resources.colors.whiteColor),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360"),
                ),
                Positioned(
                  right: -10,
                    bottom:10,
                    child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Resources.colors.themeColor,
                ))
              ],
            ), SizedBox(height: MediaQuery.of(context).size.height * .03),
            _buildTextField(
                controller: _nameController,
                labelText: 'Name',
                icon: Icons.person),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            _buildTextField(
                controller: _dobController,
                labelText: 'Dob',
                icon: Icons.date_range),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            _buildTextField(
                controller: _genderController,
                labelText: 'Gender',
                icon: Icons.transgender),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            _buildTextField(
                controller: _bioController,
                labelText: 'Bio',
                icon: Icons.text_fields),
          ],
        ),
      ),
    );
  }

  // Helper function for TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Resources.colors.themeColor),
          labelStyle: TextStyle(color: Resources.colors.blackColor),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Resources.colors.blackColor.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Resources.colors.blackColor.withOpacity(0.1), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Resources.colors.blackColor.withOpacity(0.1), width: 1),
          ),
          contentPadding: const EdgeInsets.all(5)),
      style: TextStyle(color: Resources.colors.blackColor),
    );
  }
}
