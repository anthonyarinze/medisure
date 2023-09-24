import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medisure/authentication/login.dart';
import 'package:medisure/firebase_options.dart';
import 'package:medisure/pages/alerts.dart';
import 'package:medisure/pages/claims.dart';
import 'package:medisure/pages/doctors.dart';
import 'package:medisure/pages/policies.dart';
import 'package:medisure/pages/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  int _currentIndex = 0;
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: [
          SalomonBottomBarItem(icon: const Icon(Icons.policy_rounded), title: const Text("Policies")),
          SalomonBottomBarItem(icon: const Icon(Icons.local_hospital_rounded), title: const Text("Doctors")),
          SalomonBottomBarItem(icon: const Icon(Icons.article), title: const Text("Claims")),
          SalomonBottomBarItem(icon: const Icon(Icons.account_box_outlined), title: const Text("Profile")),
          SalomonBottomBarItem(icon: const Icon(Icons.notifications_outlined), title: const Text("Alerts")),
        ],
      ),
    );
  }
}
