import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mythos_manager/features/home/presentation/screens/home_page.dart';
import 'package:mythos_manager/shared/presentation/components/box_shadow_image.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mythos Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC7AA87)),
        primaryColor: const Color(0xFFC7AA87),
        fontFamily: GoogleFonts.openSans().fontFamily,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF90714A),
          titleTextStyle: GoogleFonts.openSans(
            fontSize: 25,
            color: Colors.black
          )
        )
      ),
      home: const HomePage(),
    );
  }
}

