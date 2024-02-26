// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:chatbot/ui/History.dart';
import 'package:chatbot/ui/accounts.dart';
import 'package:chatbot/ui/chat.dart';
import 'package:chatbot/ui/feedback.dart';
import 'package:chatbot/ui/home.dart';
import 'package:flutter/material.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({Key? key}) : super(key: key);

  @override
  _UserHomepageState createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    ChatPage(
        maintitle: 'Title', // Replace with the actual title you want to pass
        message: 'Message', // Replace with the actual message you want to pass
        isSender: true, // Replace with the actual sender value
        time: DateTime.now()),
    const HistoryPage(),
    const MyApp(),
    const AccountDetailsPage(
      enteredUsername: 'username',
      enteredEmail: 'email',
      enteredMobileNumber: 'mobileNumber',
      enteredDOB: 'dob',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigatorBottomBar,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_sharp),
              label: "chatbot",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Feedback",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "User Account",
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
