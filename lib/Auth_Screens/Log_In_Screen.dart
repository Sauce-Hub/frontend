import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Auth_Screens/Forget_Password.dart';
import 'package:frontend/Home_Screens/Home_Tab.dart';
import 'package:frontend/Home_Screens/Navigation.dart';
import 'package:frontend/network/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  

  bool _isPasswordObscured = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // =========================
  // Login Function
  // =========================
  Future<void> _login() async {
    // Basic validation
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
  print('Login Response: ${response.data}');

  // ==== احفظي التوكن هنا ====
  if (response.statusCode == 200 || response.statusCode == 201) {
  print('Login Response: ${response.data}');

  // ==== احفظي التوكن والـ user ID هنا ====

  final token = response.data['token'];
  final userId = response.data['user']['user_id'];

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('user_token', token);
  await prefs.setInt('user_id', userId);

  print('TOKEN SAVED: $token');
  print('USER ID SAVED: $userId');
}
  // ==========================


        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;

              final tween = Tween(
                begin: begin,
                end: end,
              );

              final offsetAnimation = animation.drive(tween);

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

      String message = 'Something went wrong';

      if (e.response != null) {
        print('Status Code: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');

        message = e.response?.data['message'] ??
            'Invalid email or password';
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
      backgroundColor: const Color(0xFFFAF9F6),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF97316),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Sauce Hub',
          style: TextStyle(
            color: Color(0xFFF97316),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 10),

              // =========================
              // Logo
              // =========================
              Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8F2),
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Center(
                  child: Image.asset(
                    "assets/Logo.png",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Title
              // =========================
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Log in to discover delicious new recipes.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // =========================
              // Login Card
              // =========================
              Container(
                padding: const EdgeInsets.all(20.0),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // =========================
                    // Email
                    // =========================
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        hintText: 'Enter your email',

                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFF97316),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =========================
                    // Password
                    // =========================
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _passwordController,

                      obscureText: _isPasswordObscured,

                      decoration: InputDecoration(
                        hintText: 'Enter your password',

                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,

                            color: Colors.grey.shade600,
                            size: 20,
                          ),

                          onPressed: () {
                            setState(() {
                              _isPasswordObscured =
                                  !_isPasswordObscured;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFF97316),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =========================
                    // Forgot Password
                    // =========================
                    Align(
                      alignment: Alignment.centerRight,

                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForgotPasswordScreen(),
                            ),
                          );
                        },

                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),

                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFFF97316),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // Login Button
                    // =========================
                    SizedBox(
                      width: double.infinity,
                      height: 48,

                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFF97316),

                          disabledBackgroundColor:
                              const Color(0xFFF97316)
                                  .withOpacity(0.6),

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                        ),

                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Log In',

                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================
              // Sign Up
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Navigate to Register Screen
                    },

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),

                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFFF97316),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 90),

              const Text(
                'Taste. Connect. Create',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}