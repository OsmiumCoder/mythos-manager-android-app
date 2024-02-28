import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';
import 'package:mythos_manager/features/home/presentation/screens/screens.dart';
import 'unknown_screen.dart';
/// Router class
///
/// Author: Shreif Abdalla

class AppRouter {

  static const String homeScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/sign-up';

  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen(),
        );
      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen(),
        );
    }
    if(kDebugMode) {
      return MaterialPageRoute(builder: (context) => const UnknownScreen(),
      );
    }
    else {
      return MaterialPageRoute(builder: (context) => const HomeScreen(),
      );
    }
    }
  }

