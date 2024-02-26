import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mythos_manager/home/presentation/home_view.dart';
import 'package:mythos_manager/shared/presentation/components/box_shadow_image.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff90714A)),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

