import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/auth_provider.dart';
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

  loadData() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.fetchUserDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      loadData();

    if (authProvider.userDetails != null) {
      _nameController.text = authProvider.userDetails?['name'] ?? '';
      _dobController.text = authProvider.userDetails?['dob'] ?? '';
      _bioController.text = authProvider.userDetails?['bio'] ?? '';
      _genderController.text = authProvider.userDetails?['gender'] ?? '';
    }
  }

  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
        ),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              // Consumer<AuthProvider>(builder: (context, provider, child) {
              //   return Stack(
              //     clipBehavior: Clip.none,
              //     children: [
              //       CircleAvatar(
              //         radius: 50,
              //         backgroundColor: Resources.colors.themeColor,
              //         backgroundImage: provider.profileImage != null
              //             ? FileImage(File(provider.profileImage!.path))
              //             : provider.userDetails?["profilePic"] != null &&
              //                     provider.userDetails?["profilePic"] != ""
              //                 ? NetworkImage(
              //                     provider.userDetails!["profilePic"])
              //                 : NetworkImage(Resources.images.noImages)
              //                     as ImageProvider,
              //       ),
              //
              //     ],
              //   );
              // }),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              _buildTextField(
                  controller: _nameController,
                  onChanged: (value) {},
                  labelText: 'Name',
                  icon: Icons.person),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              _buildTextField(
                  controller: _dobController,
                  onChanged: (value) {},
                  labelText: 'Dob',
                  icon: Icons.date_range),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              _buildTextField(
                  controller: _genderController,
                  onChanged: (value) {},
                  labelText: 'Gender',
                  icon: Icons.transgender),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              _buildTextField(
                  controller: _bioController,
                  onChanged: (value) {},
                  labelText: 'Bio',
                  icon: Icons.text_fields),
              SizedBox(height: MediaQuery.of(context).size.height * .05),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await provider.updateUserDetails(
                          _nameController.text.trim(),
                          _dobController.text.trim(),
                          _bioController.text.trim(),
                          _genderController.text.trim());
                      if (provider.errorMessage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Profile updated successfully!")),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(provider.errorMessage!)),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Resources.colors.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black45,
                      elevation: 5,
                    ),
                    child: provider.isLoading
                        ? CircularProgressIndicator(
                            color: Resources.colors.whiteColor,
                          )
                        : Text(
                            'Update Profile',
                            style: Resources.styles
                                .kTextStyle16B(Resources.colors.whiteColor),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Helper function for TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
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
