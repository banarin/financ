import 'package:finance/splashScreen.dart';
import 'package:finance/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FINANC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff11998e)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}