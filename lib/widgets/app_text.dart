import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// Text styles for the app
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextType type;

  const AppText.heading(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = TextType.heading;

  const AppText.subheading(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = TextType.subheading;

  const AppText.body(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = TextType.body;

  const AppText.caption(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = TextType.caption;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    TextStyle baseStyle;
    switch (type) {
      case TextType.heading:
        baseStyle = TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? AppTheme.textColor : AppTheme.primaryColor,
          letterSpacing: 0.3,
          height: 1.2,
        );
        break;
      case TextType.subheading:
        baseStyle = TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
          letterSpacing: 0.2,
        );
        break;
      case TextType.body:
        baseStyle = TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
          height: 1.5,
          letterSpacing: 0.2,
        );
        break;
      case TextType.caption:
        baseStyle = TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? AppTheme.textSecondaryColor : AppTheme.textSecondaryColor,
          height: 1.4,
        );
        break;
    }

    // Merge with custom style if provided
    final finalStyle = style != null ? baseStyle.merge(style) : baseStyle;

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum TextType {
  heading,
  subheading,
  body,
  caption,
}
