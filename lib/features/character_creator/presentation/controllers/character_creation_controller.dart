import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/character.dart';

/// Author: Liam Welsh
///
/// Provides an empty [Character] for character creation
final characterCreationProvider =
    StateProvider<Character>((ref) => Character.withCollectionsInitialized());
