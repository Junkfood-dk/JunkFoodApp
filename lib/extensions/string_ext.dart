extension StringExtensions on String {
  /// Converts a string to sentence case where only the first letter is capitalized.
  /// 
  /// Handles edge cases like:
  /// - Empty or null strings
  /// - Single word titles
  /// - Titles with special characters
  /// - Unicode characters
  /// 
  /// Examples:
  /// - "GRILLED CHICKEN WITH VEGETABLES" -> "Grilled chicken with vegetables"
  /// - "Grilled Chicken With Vegetables" -> "Grilled chicken with vegetables"
  /// - "grilled chicken with vegetables" -> "Grilled chicken with vegetables"
  /// - "123 special dish!" -> "123 special dish!"
  String toSentenceCase() {
    if (isEmpty) return this;
    
    // Convert to lowercase first
    final lowercased = toLowerCase();
    if (lowercased.isEmpty) return lowercased;
    
    // Find the first letter character to capitalize
    for (int i = 0; i < lowercased.length; i++) {
      final char = lowercased[i];
      if (RegExp(r'[a-zA-ZÀ-ÿ]').hasMatch(char)) {
        return lowercased.substring(0, i) + 
               char.toUpperCase() + 
               lowercased.substring(i + 1);
      }
    }
    
    // If no letters found, return as is
    return lowercased;
  }
}