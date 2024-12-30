import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _handleRegister(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final phone = _phoneController.text.trim();
      final bio = _bioController.text.trim();
      final dob = _dobController.text.trim();
      final gender = _genderController.text.trim();
      final profilePic = "";
      final  backgroundPic="";

      final user = await authProvider.registerUser(
          name, email, password, phone, bio, dob, gender,profilePic,backgroundPic);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        GoRouter.of(context).pushNamed(RoutesName.loginScreen);
        // Navigate to login screen or home screen
      } else if (authProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage!)),
        );
      }
    }
  }

  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF673AB7), Color(0xFF3F3D55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),

                // Welcome Text
                Text(
                  'Create Account',
                  style: Resources.styles.kTextStyle26B(Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please fill the details to register',
                  style: Resources.styles.kTextStyle16(Colors.white70),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Name TextField
                _buildTextFormField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your full name';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                _buildTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your phone number';
                    } else if (value.length != 10) {
                      return 'Phone number should be 10 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Date of Birth TextField
                _buildTextFormField(
                    controller: _dobController,
                    labelText: 'DOB',
                    icon: Icons.calendar_today_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your date of birth';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Gender TextField
                _buildTextFormField(
                    controller: _genderController,
                    labelText: 'Gender',
                    icon: Icons.calendar_today_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your gender';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Email TextField with validation
                _buildTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Password TextField with validation
                _buildTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a password';
                      } else if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Confirm Password TextField with validation
                _buildTextFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),

                // Bio TextField
                _buildTextFormField(
                    controller: _bioController,
                    labelText: 'Bio',
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a bio';
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                SizedBox(height: MediaQuery.of(context).size.height * .05),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () => _handleRegister(authProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Resources.colors.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * .01),

                // Already have an account? Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Resources.styles.kTextStyle14(Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(RoutesName.loginScreen);
                      },
                      child: Text(
                        'Login',
                        style: Resources.styles.kTextStyle16B(Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function for TextFormField widget
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(5),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
