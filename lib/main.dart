// ignore_for_file: non_constant_identifier_names, camel_case_types
import 'package:chatbot/firebase_options.dart';
import 'package:chatbot/userHomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp_3());
}

class MyApp_3 extends StatefulWidget {
  const MyApp_3({super.key});

  @override
  State<MyApp_3> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp_3> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ENJOY WITH CHAT",
      home: UserHomepage(),
    );
  }
}
