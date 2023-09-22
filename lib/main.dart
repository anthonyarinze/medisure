import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medisure/pages/alerts.dart';
import 'package:medisure/pages/claims.dart';
import 'package:medisure/pages/doctors.dart';
import 'package:medisure/pages/policies.dart';
import 'package:medisure/pages/profile.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Master(),
    );
  }
}

class Master extends StatefulWidget {
  const Master({super.key});

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  List<Widget> screens = [
    const Policies(),
    const Doctors(),
    const Claims(),
    const Profile(),
    const Alerts(),
  ];

  final List _children = [];

  int _currentIndex = 0;

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Policies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Policies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Policies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Policies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Policies",
          ),
        ],
      ),
    );
  }
}
