import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A custom container with consistent styling for the app
class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool hasShadow;
  final bool hasBorder;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.hasShadow = true,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? 
            (isDarkMode ? AppTheme.primaryColorLight : AppTheme.primaryColorLight),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: hasBorder ? Border.all(
          color: isDarkMode 
              ? AppTheme.primaryColor.withAlpha(80) 
              : AppTheme.primaryColor.withAlpha(40),
          width: 1,
        ) : null,
        boxShadow: hasShadow ? [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: isDarkMode ? 6 : 8,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: child,
    );
  }
}
