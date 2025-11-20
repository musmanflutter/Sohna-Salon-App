import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:sohna_salon_app/screens/splash_screen.dart';

final themeSet = ThemeData(
  useMaterial3: false,
  primaryColor: Color(0xFFc10100),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFc10100),
    onPrimary: Colors.white,
    secondary: Color(0xFFc10100),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    primaryContainer: Color(0xFFffe7e0),
    onPrimaryContainer: Colors.black,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeSet,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
