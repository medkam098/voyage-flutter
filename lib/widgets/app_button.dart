import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A custom button widget with consistent styling for the app
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isPrimary;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.padding,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isPrimary
          ? (isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor)
          : (isDarkMode ? AppTheme.surfaceColor : AppTheme.secondaryColorLight),
      foregroundColor: isPrimary
          ? Colors.white
          : (isDarkMode ? AppTheme.textColor : AppTheme.primaryColor),
      elevation: isDarkMode ? 1 : 2,
      shadowColor: AppTheme.shadowColor,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPrimary
            ? BorderSide.none
            : BorderSide(
                color: isDarkMode
                    ? AppTheme.dividerColor
                    : AppTheme.primaryColor.withAlpha(30),
                width: 1,
              ),
      ),
    );

    final textStyle = TextStyle(
      fontFamily: AppTheme.fontFamily,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: 0.3,
    );

    Widget buttonChild;
    if (icon != null) {
      buttonChild = Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text, style: textStyle),
        ],
      );
    } else {
      buttonChild = Text(text, style: textStyle);
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }
}
