import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

const double _desktopBreakpoint = 800.0;

/// A provider that holds the current width of the application from [MediaQuery.sizeOf(context)].
///
/// This provider should be overridden in the widget tree (e.g., in `MaterialApp`)
/// to provide the actual screen width.
final screenWidthProvider = Provider<double>((ref) {
  // Default/placeholder value. This should always be overridden.
  return 0.0;
});

/// A Riverpod provider that determines if the app should display a desktop-like
/// layout based on the current screen width from [screenWidthProvider].
///
/// It watches `screenWidthProvider` and recalculates whenever the width changes.
final isDesktopLayoutProvider = Provider<bool>(
  (ref) {
    // Only consider desktop layout on web platforms
    if (!kIsWeb) return false;
    
    final double currentWidth = ref.watch(screenWidthProvider);
    return currentWidth >= _desktopBreakpoint;
  },
  dependencies: [screenWidthProvider],
);
