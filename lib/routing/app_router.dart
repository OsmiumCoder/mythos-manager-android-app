import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/presentation/screens/screens.dart';
import 'package:mythos_manager/features/campaigns/presentation/screens/campaign_creation_screen.dart';
import 'package:mythos_manager/features/home/presentation/screens/screens.dart';
import '../features/characters/presentation/screens/characters_screen.dart';
import 'unknown_screen.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/screens.dart';

/// Router class
///
/// Author: Shreif Abdalla
class AppRouter {
  static const String homeScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/sign-up';
  static const String charactersScreen = "/characters";
  static const String backstorySelectionScreen =
      '/characters/creator/backstory-selection';
  static const String backgroundSelectionScreen =
      '/characters/creator/background-selection';
  static const String raceSelectionScreen =
      '/characters/creator/race-selection';
  static const String abilitySelectionScreen =
      '/characters/creator/ability-selection';
  static const String classSelectionScreen = '/characters/creator/class-selection';
  static const String campaignCreationScreen = '/campaigns/creator';

  // Screens that do not require authentication
  static const noAuthScreens = [loginScreen, signupScreen];

  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings, WidgetRef ref) {
    User? auth = ref.read(authenticationStateProvider).value;

    if (auth == null && !noAuthScreens.contains(settings.name)) {
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }

    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => const CharactersScreen(),
        );
      case raceSelectionScreen:
        return MaterialPageRoute(builder: (_) => const RaceSelectionScreen());
      case classSelectionScreen:
        return MaterialPageRoute(builder: (_) => const ClassSelectionScreen());
      case backstorySelectionScreen:
        return MaterialPageRoute(
          builder: (_) => const BackstorySelectionScreen(),
        );
      case backgroundSelectionScreen:
        return MaterialPageRoute(
          builder: (_) => const BackgroundSelectionScreen(),
        );
      case abilitySelectionScreen:
        return MaterialPageRoute(
          builder: (_) => const AbilitySelectionScreen(),
        );
      case campaignCreationScreen:
        return MaterialPageRoute(
          builder: (_) => const CampaignCreationScreen(),
        );
    }
    if (kDebugMode) {
      return MaterialPageRoute(builder: (_) => const UnknownScreen());
    } else {
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
