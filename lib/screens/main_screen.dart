import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskys/screens/completed_screen.dart';
import 'package:taskys/screens/home_screen.dart';
import 'package:taskys/screens/profile_screen.dart';
import 'package:taskys/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TodoScreen(),
    CompletedScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/todo.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/completed.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/profile.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
