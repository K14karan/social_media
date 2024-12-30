import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthProvider authProvider;
  loadData() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .05),

              // Welcome Text
              Text(
                'Welcome Back!',
                style: Resources.styles.kTextStyle26B(Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Please sign in to continue',
                style: Resources.styles.kTextStyle16(Colors.white70),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05),

              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email TextField
                    _buildTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      icon: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an email address';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),

                    // Password TextField
                    _buildTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: Resources.styles.kTextStyle16B(Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final user = await authProvider.loginUser(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              if (user != null) {
                                // Successful login, navigate to the next screen
                                GoRouter.of(context)
                                    .pushNamed(RoutesName.navigationScreen);
                              } else {
                                // Login failed, show an error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Login failed. Please try again.')),
                                );
                              }
                            } catch (e) {
                              // Catch any exceptions and show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${e.toString()}')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.black45,
                          elevation: 5,
                        ),
                        child: authProvider.isLoading
                            ? CircularProgressIndicator(
                                color: Resources.colors.themeColor)
                            : Text(
                                'Login',
                                style: Resources.styles
                                    .kTextStyle16B(Resources.colors.themeColor),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Or login with
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white70,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white70,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Social Media Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata_outlined,
                          color: Colors.red,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Don't have an account? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Resources.styles
                              .kTextStyle14(Resources.colors.whiteColor),
                        ),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RoutesName.registerScreen);
                          },
                          child: Text(
                            'Register',
                            style: Resources.styles
                                .kTextStyle16B(Resources.colors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for TextFormField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
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

  // Helper function for Social Media buttons
  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
