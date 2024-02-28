import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/themes/theme_data.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mythos Manager',
      theme: themeData,
      initialRoute: AppRouter.signupScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

