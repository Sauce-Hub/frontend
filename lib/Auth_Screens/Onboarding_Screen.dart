import 'package:flutter/material.dart';

 class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F2),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ]
          ),
          child: Column(

            //image
            mainAxisSize: MainAxisSize.min,
            children: [
               Image.asset("assets/Logo.png",
               height: 60,
               fit: BoxFit.contain,
               ),
               const SizedBox(height: 28),
              Row(
                children: [
                Text(
            'Welcome to ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            'SAUCE HUB ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color:Color(0xFFF97316) ,
            ),
          ),
          const SizedBox(height: 12),
            ],),

          // Subtitle Description
          const Text(
            'Discover delicious recipes, share your creations, and connect with food lovers.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

          // Log In Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:(Color(0xFFF97316)),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFF97316), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFFF97316),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
            'Taste.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            'Connect.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color:Color(0xFFF97316) ,
            ),
          ),
          Text(
            'Create.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

            ],
          ),],
      ),
      
      ),),
    );
  }
}
