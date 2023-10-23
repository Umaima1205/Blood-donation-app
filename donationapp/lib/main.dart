import 'package:Zindgi/firebase_options.dart';
import 'package:Zindgi/screens/Splash_Screen.dart';
import 'package:Zindgi/utility/App_Colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: AppColors.RedColor,
      ),
      home: const SplashScreen(),
    );
  }
}