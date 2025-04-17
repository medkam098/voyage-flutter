import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A badge widget with consistent styling for the app
class AppBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const AppBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    final badgeBackgroundColor = backgroundColor ?? 
        (isDarkMode ? AppTheme.primaryColorLight : AppTheme.primaryColorLight);
    
    final badgeTextColor = textColor ?? 
        (isDarkMode ? AppTheme.textColor : AppTheme.primaryColor);

    final badge = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: badgeBackgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode 
              ? AppTheme.primaryColor.withAlpha(80) 
              : AppTheme.primaryColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: badgeTextColor,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: badge,
      );
    }

    return badge;
  }
}
