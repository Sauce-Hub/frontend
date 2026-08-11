import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Add_Post_Screen.dart';
import 'package:frontend/Home_Screens/Chatbot_Screen.dart';
import 'package:frontend/Home_Screens/Home_Tab.dart';
import 'package:frontend/Home_Screens/Profile_Screen.dart';
import 'package:frontend/Home_Screens/Search_Screen.dart';
import 'package:frontend/Widgets/Bottom_Bar_Items.dart';

import 'package:frontend/Widgets/Post_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
 

  final List<Widget> screens = [
    HomeTab(),        
    const SearchScreen(),
    const ChatbotScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: _pageController, 
        children: screens,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AddPostScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0, 1);
                              const end = Offset.zero;
                              final tween = Tween(begin: begin, end: end);
                              final offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                      ),
                );
        },
        child: Icon(Icons.add, color: Colors.black, size: 30,),
        backgroundColor: Color(0xFFF97316),

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

