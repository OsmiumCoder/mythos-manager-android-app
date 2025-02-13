/// Author: Jonathon Meney
///
/// String extension for capitalizing a string
extension CapitalizeString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
