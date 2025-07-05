import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

/// Determines if the Flutter app is running in a web browser and
/// if the URL contains the query parameter 'desktop=true'.
///
/// Returns `true` if both conditions are met, otherwise returns `false`.
bool _isWebAndDesktopMode() {
  if (kIsWeb) {
    // kIsWeb is true, so we are in a web browser.
    // Now check the URL for 'desktop=true'.
    final Uri uri = Uri.base;
    return uri.queryParameters.containsKey('desktop') &&
        uri.queryParameters['desktop'] == 'true';
  }
  // Not running on the web, so desktop mode for web is irrelevant.
  return false;
}

/// A Riverpod provider that exposes whether the app is running in web
/// and has 'desktop=true' in its URL query parameters.
final isDesktopWebProvider = Provider<bool>((ref) {
  return _isWebAndDesktopMode();
});
