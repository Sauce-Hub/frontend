import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:frontend/Auth_Screens/Log_In_Screen.dart';
import 'package:frontend/Home_Screens/Navigation.dart';
import 'package:frontend/network/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();


  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // =========================
  // Register Function
  // =========================

  Future<void> _register() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService().register(
        name: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        // Registration successful

        print('Register Response: ${response.data}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
          ),
        );

        // Go to Home
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    const HomeScreen(),

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;

              final tween = Tween(
                begin: begin,
                end: end,
              );

              final offsetAnimation =
                  animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;

      print('Register Error: ${e.response?.data}');

      String message = 'Something went wrong';

      if (e.response != null) {
        final data = e.response?.data;

        if (data is Map<String, dynamic>) {
          message = data['message']?.toString() ??
              'Registration failed';
        } else {
          message = 'Registration failed';
        }
      } else {
        message = 'Could not connect to the server';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      print('Unexpected Error: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,

            padding:
                const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              children: [

                // =========================
                // Header
                // =========================

                SizedBox(
                  height: 60,

                  child: Row(
                    children: [

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5D4740),
                          size: 24,
                        ),

                        padding: EdgeInsets.zero,
                      ),

                      Expanded(
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 48),

                            child: const Text(
                              'Create Account',

                              style: TextStyle(
                                color: Color(0xFFFF6338),
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // =========================
                // Logo
                // =========================

                Image.asset(
                  "assets/Logo.png",
                  height: 60,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 18),

                const Text(
                  'Sauce Hub',

                  style: TextStyle(
                    color: Color(0xFFFF6338),
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Taste Connect Create',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Color(0xFF5D4740),
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // Form Card
                // =========================

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.fromLTRB(
                    24,
                    24,
                    24,
                    22,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.035),
                        blurRadius: 18,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // =========================
                      // Username
                      // =========================

                      _buildLabel('Username'),

                      const SizedBox(height: 6),

                      TextFormField(
                        controller:
                            _usernameController,

                        textInputAction:
                            TextInputAction.next,

                        keyboardType:
                            TextInputType.text,

                        textCapitalization:
                            TextCapitalization.none,

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your username';
                          }

                          return null;
                        },

                        decoration: _inputDecoration(
                          hintText:
                              'Enter your username',

                          icon:
                              Icons.person_outline,
                        ),
                      ),

                      const SizedBox(height: 17),

                      // =========================
                      // Email
                      // =========================

                      _buildLabel('Email'),

                      const SizedBox(height: 6),

                      TextFormField(
                        controller:
                            _emailController,

                        textInputAction:
                            TextInputAction.next,

                        keyboardType:
                            TextInputType.emailAddress,

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },

                        decoration: _inputDecoration(
                          hintText:
                              'Enter your email',

                          icon:
                              Icons.email_outlined,
                        ),
                      ),

                      const SizedBox(height: 17),

                      // =========================
                      // Password
                      // =========================

                      _buildLabel('Password'),

                      const SizedBox(height: 6),

                      TextFormField(
                        controller:
                            _passwordController,

                        textInputAction:
                            TextInputAction.next,

                        obscureText:
                            _obscurePassword,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter a password';
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }

                          return null;
                        },


                        decoration: _inputDecoration(
                          hintText:
                              'Create a password',

                          icon:
                              Icons.lock_outline,

                          suffixIcon:
                              IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword;
                              });
                            },

                            icon: Icon(
                              _obscurePassword
                                  ? Icons
                                      .visibility_outlined
                                  : Icons
                                      .visibility_off_outlined,

                              color:
                                  const Color(0xFFB4A6A1),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 17),

                      // =========================
                      // Register Button
                      // =========================

                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed:
                              _isLoading
                                  ? null
                                  : _register,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFF6338),

                            disabledBackgroundColor:
                                const Color(0xFFFF6338)
                                    .withOpacity(0.6),

                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                          ),

                          child: _isLoading
                              ? const SizedBox(
                                  width: 23,
                                  height: 23,

                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Create Account',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =========================
                      // Terms
                      // =========================

                      Center(
                        child: RichText(
                          textAlign:
                              TextAlign.center,

                          text: TextSpan(
                            style:
                                const TextStyle(
                              color:
                                  Color(0xFF5D4740),
                              fontSize: 12,
                              height: 1.4,
                            ),

                            children: [

                              const TextSpan(
                                text:
                                    'By creating an account, you agree to our ',
                              ),

                              const TextSpan(
                                text:
                                    'Terms of\nService',

                                style: TextStyle(
                                  color:
                                      Color(0xFFFF6338),
                                ),
                              ),

                              const TextSpan(
                                text: ' & ',
                              ),

                              const TextSpan(
                                text:
                                    'Privacy Policy',

                                style: TextStyle(
                                  color:
                                      Color(0xFFFF6338),
                                ),
                              ),

                              const TextSpan(
                                text: '.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // =========================
                // Login
                // =========================

                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 25),

                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color:
                            Color(0xFF5D4740),
                        fontSize: 15,
                      ),

                      children: [

                        const TextSpan(
                          text:
                              'Already have an account? ',
                        ),

                        WidgetSpan(
                          child:
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,

                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                  ) =>
                                      const LoginScreen(),

                                  transitionsBuilder:
                                      (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin =
                                        Offset(0, 1);

                                    const end =
                                        Offset.zero;

                                    final tween =
                                        Tween(
                                      begin: begin,
                                      end: end,
                                    );

                                    final
                                        offsetAnimation =
                                        animation.drive(
                                      tween,
                                    );

                                    return SlideTransition(
                                      position:
                                          offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },

                            child: const Text(
                              'Log In',

                              style: TextStyle(
                                color:
                                    Color(0xFFFF6338),
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // Label
  // =========================

  Widget _buildLabel(String text) {
    return Text(
      text,

      style: const TextStyle(
        color: Color(0xFF5D4740),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // =========================
  // Input Decoration
  // =========================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: Color(0xFFB4A6A1),
        fontSize: 16,
      ),

      prefixIcon: Icon(
        icon,
        color: const Color(0xFFB4A6A1),
        size: 22,
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(8),

        borderSide: const BorderSide(
          color: Color(0xFFEDE4DE),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(8),

        borderSide: const BorderSide(
          color: Color(0xFFEDE4DE),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(8),

        borderSide: const BorderSide(
          color: Color(0xFFFF6338),
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(8),

        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(8),

        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),

      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 11.5,
        height: 1.2,
      ),
    );
  }
}