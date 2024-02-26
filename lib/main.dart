import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mythos_manager/features/home/presentation/screens/home_page.dart';
import 'package:mythos_manager/shared/presentation/components/mythos_theme_data.dart';
import 'firebase_options.dart';


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
      theme: mythosThemeData,
      home: const HomePage(),
    );
  }
}

