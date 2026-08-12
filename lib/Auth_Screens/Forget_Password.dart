import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 247, 240),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF97316),
          ),
        ),

        title: const Text(
          'Sauce hub',
          style: TextStyle(
            color: Color(0xFFF97316),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 70,
            ),

            child: Column(
              children: [

                // Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 42,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      // Lock Icon
                      Container(
                        width: 96,
                        height: 96,

                        decoration: const BoxDecoration(
                          color: Color(0xFFFFDCD2),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.lock_reset,
                          color: Color(0xFFF97316),
                          size: 50,
                        ),
                      ),

                      const SizedBox(height: 38),

                      // Title
                      const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF292929),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Description
                      const Text(
                        "Enter your email and we'll send you a\n"
                        "link to reset your password.",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 17,
                          height: 1.5,
                          color: Color(0xFF655B57),
                        ),
                      ),

                      const SizedBox(height: 38),

                      // Email Label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'EMAIL',

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Email TextField
                      TextField(
                        keyboardType: TextInputType.emailAddress,

                        decoration: InputDecoration(
                          hintText: 'Enter your email',

                          hintStyle: const TextStyle(
                            color: Color(0xFFAAA5A3),
                            fontSize: 16,
                          ),

                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF655B57),
                          ),

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFF97316),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      // Send Link Button
                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          onPressed: () {
                          
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF97316),
                            foregroundColor: Colors.white,

                            elevation: 2,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: const Text(
                            'SEND LINK ',

                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                // Return to Login
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF655B57),
                  ),

                  child: const Text(
                    '←  Return to Login',

                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
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
}