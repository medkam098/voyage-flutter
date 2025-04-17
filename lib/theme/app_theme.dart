import 'package:flutter/material.dart';

/// App theme constants to maintain consistent styling across the application
class AppTheme {
  // Theme mode
  static bool isDarkMode = false;

  // Set theme mode
  static void setThemeMode(bool darkMode) {
    isDarkMode = darkMode;
  }

  // Font family
  static const String fontFamily = 'Plus Jakarta Sans';

  // Light Theme Colors - High contrast palette with subtle backgrounds
  static const Color _lightPrimaryColor = Color(
    0xFF0047B3,
  ); // Deeper Blue for better contrast
  static const Color _lightPrimaryColorLight = Color(
    0xFFEBF5FF,
  ); // Very light blue for subtle backgrounds
  static const Color _lightSecondaryColor = Color(
    0xFF212121,
  ); // Almost Black for text
  static const Color _lightSecondaryColorLight = Color(
    0xFFF8F9FA,
  ); // Very light gray for subtle backgrounds
  static const Color _lightAccentColor = Color(
    0xFFD04A02,
  ); // Darker Orange for better contrast
  static const Color _lightAccentColorLight = Color(
    0xFFFFF4E6,
  ); // Very light orange for subtle backgrounds
  static const Color _lightTextColor = Color(
    0xFF212121,
  ); // Almost black for text
  static const Color _lightTextSecondaryColor = Color(
    0xFF424242,
  ); // Dark gray for secondary text
  static const Color _lightTextInverseColor =
      Colors.white; // White text for dark backgrounds
  static const Color _lightBackgroundColor = Colors.white; // White background
  static const Color _lightSurfaceColor = Color(
    0xFFF8F9FA,
  ); // Light Grey surface
  static const Color _lightErrorColor = Color(
    0xFFB71C1C,
  ); // Deep Red for errors
  static const Color _lightCaptionColor = Color(
    0xFF616161,
  ); // Darker Grey for captions
  static const Color _lightDividerColor = Color(
    0xFFE0E0E0,
  ); // Light Grey for dividers
  static const Color _lightCardColor = Colors.white; // White card background
  static const Color _lightIconColor = Color(
    0xFF0047B3,
  ); // Deeper Blue for icons
  static const Color _lightShadowColor = Color(0x1A000000); // Subtle shadow

  // Dark Theme Colors - Very subtle backgrounds with high contrast text
  static const Color _darkPrimaryColor = Color(
    0xFF4DA6FF,
  ); // Bright blue for good contrast
  static const Color _darkPrimaryColorLight = Color(
    0xFF172338,
  ); // Very subtle blue background
  static const Color _darkSecondaryColor = Color(
    0xFFEEEEEE,
  ); // Light grey for maximum contrast
  static const Color _darkSecondaryColorLight = Color(
    0xFF2C2C2C,
  ); // Subtle gray background
  static const Color _darkAccentColor = Color(
    0xFFFFB74D,
  ); // Warm orange for good visibility
  static const Color _darkAccentColorLight = Color(
    0xFF2D2417,
  ); // Very subtle orange background
  static const Color _darkTextColor = Color(
    0xFFF5F5F5,
  ); // Almost white for text
  static const Color _darkTextSecondaryColor = Color(
    0xFFBDBDBD,
  ); // Light gray for secondary text
  static const Color _darkTextInverseColor = Color(0xFF121212); // Almost black
  static const Color _darkBackgroundColor = Color(
    0xFF121212,
  ); // Subtle dark background
  static const Color _darkSurfaceColor = Color(
    0xFF1E1E1E,
  ); // Slightly lighter than background
  static const Color _darkErrorColor = Color(
    0xFFFF5252,
  ); // Bright red for errors
  static const Color _darkCaptionColor = Color(
    0xFFBDBDBD,
  ); // Light grey for captions
  static const Color _darkDividerColor = Color(
    0xFF383838,
  ); // Medium grey for dividers
  static const Color _darkCardColor = Color(
    0xFF1E1E1E,
  ); // Very subtle card background
  static const Color _darkIconColor = Color(0xFF64B5F6); // Light blue for icons
  static const Color _darkShadowColor = Color(0x40000000); // Subtle shadow

  // Dynamic colors based on theme
  static Color get primaryColor =>
      isDarkMode ? _darkPrimaryColor : _lightPrimaryColor;
  static Color get primaryColorLight =>
      isDarkMode ? _darkPrimaryColorLight : _lightPrimaryColorLight;
  static Color get secondaryColor =>
      isDarkMode ? _darkSecondaryColor : _lightSecondaryColor;
  static Color get secondaryColorLight =>
      isDarkMode ? _darkSecondaryColorLight : _lightSecondaryColorLight;
  static Color get accentColor =>
      isDarkMode ? _darkAccentColor : _lightAccentColor;
  static Color get accentColorLight =>
      isDarkMode ? _darkAccentColorLight : _lightAccentColorLight;
  static Color get textColor => isDarkMode ? _darkTextColor : _lightTextColor;
  static Color get textSecondaryColor =>
      isDarkMode ? _darkTextSecondaryColor : _lightTextSecondaryColor;
  static Color get lightTextColor =>
      isDarkMode ? _darkTextInverseColor : _lightTextInverseColor;
  static Color get backgroundColor =>
      isDarkMode ? _darkBackgroundColor : _lightBackgroundColor;
  static Color get surfaceColor =>
      isDarkMode ? _darkSurfaceColor : _lightSurfaceColor;
  static Color get errorColor =>
      isDarkMode ? _darkErrorColor : _lightErrorColor;
  static Color get captionColor =>
      isDarkMode ? _darkCaptionColor : _lightCaptionColor;
  static Color get dividerColor =>
      isDarkMode ? _darkDividerColor : _lightDividerColor;
  static Color get cardColor => isDarkMode ? _darkCardColor : _lightCardColor;
  static Color get iconColor => isDarkMode ? _darkIconColor : _lightIconColor;
  static Color get shadowColor =>
      isDarkMode ? _darkShadowColor : _lightShadowColor;

  // Font weights
  static const FontWeight boldWeight = FontWeight.bold;
  static const FontWeight semiBoldWeight = FontWeight.w600;
  static const FontWeight mediumWeight = FontWeight.w500;
  static const FontWeight regularWeight = FontWeight.w400;

  // Font sizes - Consistent scale
  static const double appBarTitleSize = 22.0;
  static const double headingSize = 20.0;
  static const double subheadingSize = 18.0;
  static const double buttonTextSize = 16.0;
  static const double bodyTextSize = 16.0;
  static const double captionSize = 14.0;
  static const double drawerItemSize = 16.0;

  // Text styles - Consistent hierarchy
  static TextStyle get appBarTitleStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: boldWeight,
    fontSize: appBarTitleSize,
    color: lightTextColor,
    letterSpacing: 0.5,
  );

  static TextStyle get headingStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: boldWeight,
    fontSize: headingSize,
    color: secondaryColor,
    letterSpacing: 0.3,
  );

  static TextStyle get subheadingStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBoldWeight,
    fontSize: subheadingSize,
    color: secondaryColor,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonTextStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBoldWeight,
    fontSize: buttonTextSize,
    color: lightTextColor,
    letterSpacing: 0.5,
  );

  static TextStyle get linkTextStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: mediumWeight,
    fontSize: buttonTextSize,
    color: primaryColor,
    letterSpacing: 0.2,
  );

  static TextStyle get drawerItemStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: mediumWeight,
    fontSize: drawerItemSize,
    color: secondaryColor,
    letterSpacing: 0.2,
  );

  static TextStyle get bodyTextStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: regularWeight,
    fontSize: bodyTextSize,
    color: textColor,
    height: 1.5,
    letterSpacing: 0.2,
  );

  static TextStyle get captionStyle => TextStyle(
    fontFamily: fontFamily,
    fontWeight: regularWeight,
    fontSize: captionSize,
    color: secondaryColor,
    letterSpacing: 0.1,
  );

  // Button styles - Consistent sizing and high contrast
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor:
        isDarkMode ? _darkTextInverseColor : _lightTextInverseColor,
    minimumSize: const Size.fromHeight(50),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: isDarkMode ? 1 : 2,
  );

  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor:
        isDarkMode ? _darkTextInverseColor : _lightTextInverseColor,
    minimumSize: const Size.fromHeight(50),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: isDarkMode ? 1 : 2,
  );

  static ButtonStyle get accentButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: accentColor,
    foregroundColor:
        isDarkMode ? _darkTextInverseColor : _lightTextInverseColor,
    minimumSize: const Size.fromHeight(50),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: isDarkMode ? 1 : 2,
  );

  static ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    textStyle: linkTextStyle,
  );

  // Input decoration - Consistent styling and high contrast
  static InputDecoration inputDecoration(
    String label,
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: primaryColor),
      labelStyle: TextStyle(
        color: isDarkMode ? _darkTextColor : secondaryColor,
        fontWeight: mediumWeight,
      ),
      hintStyle: TextStyle(
        color: isDarkMode ? _darkCaptionColor : Colors.grey[600],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1.5, color: secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 1.5,
          color: isDarkMode ? _darkDividerColor : Colors.grey[400]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2, color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1.5, color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: isDarkMode ? _darkSurfaceColor : Colors.white,
    );
  }

  // Card decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color:
            isDarkMode
                ? Colors.black.withAlpha(60)
                : Colors.black.withAlpha(25),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Card styles
  static CardTheme get cardTheme => CardTheme(
    elevation: 2,
    color: cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
  );

  // List tile styles
  static ListTileThemeData get listTileTheme => const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    minLeadingWidth: 24,
    minVerticalPadding: 12,
  );

  // Icon styles
  static const double iconSizeSmall = 18.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Dialog styles
  static const EdgeInsets dialogPadding = EdgeInsets.all(16.0);
  static const double dialogBorderRadius = 8.0;
  static RoundedRectangleBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(dialogBorderRadius),
  );

  // Standard paddings
  static const EdgeInsets paddingSmall = EdgeInsets.all(8);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: 16,
  );
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: 16);
}
