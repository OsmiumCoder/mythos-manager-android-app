import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/themes/theme_data.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    // Default provider for Android is the Play Integrity provider.
    // You can use the "AndroidProvider" enum to choose your preferred provider.
    // Choose from:
    // 1. Debug provider
    // 2. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Mythos Manager',
      theme: themeData,
      initialRoute: AppRouter.homeScreen,
      onGenerateRoute: (settings) {
        return AppRouter.generateRoute(settings, ref);
      },
      // debugShowCheckedModeBanner: false,
    );
  }
}
