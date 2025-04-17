import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A divider with consistent styling for the app
class AppDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final String? label;

  const AppDivider({
    super.key,
    this.height = 16,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    if (label == null) {
      return Divider(
        height: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
      );
    }

    return Row(
      children: [
        Expanded(
          child: Divider(
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: 16,
            color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
          ),
        ),
        Text(
          label!,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            color: isDarkMode ? AppTheme.textSecondaryColor : AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            height: height,
            thickness: thickness,
            indent: 16,
            endIndent: endIndent,
            color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
          ),
        ),
      ],
    );
  }
}
