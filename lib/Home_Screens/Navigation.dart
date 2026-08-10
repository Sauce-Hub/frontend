import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Chatbot_Screen.dart';
import 'package:frontend/Home_Screens/Home_Tap.dart';
import 'package:frontend/Home_Screens/Profile_Screen.dart';
import 'package:frontend/Home_Screens/Search_Screen.dart';
import 'package:frontend/Widgets/Reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  final List<Widget> screens = const [
    HomeTab(),        
    SearchScreen(),
    ChatbotScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,   // نفس الكنترولر
        children: screens,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        color: Color.fromARGB(255, 251, 241, 214),
        notchBottomBarController: _controller,
        showLabel: true,
        elevation: 1,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          bottomBarItem(icon: Icons.home, text: 'Home'),
          bottomBarItem(icon: Icons.search, text: 'For you'),
          bottomBarItem(icon: Icons.smart_toy, text: 'Chatbot'),
          bottomBarItem(icon: Icons.person_2_outlined, text: 'Profile'),
        ],
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
        kIconSize: 24,
        kBottomRadius: 28,
      ),
    );
  }
}