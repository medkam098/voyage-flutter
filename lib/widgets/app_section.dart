import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import 'app_text.dart';

/// A section widget with consistent styling for the app
class AppSection extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasDivider;
  final bool hasBackground;
  final bool hasBorder;
  final BorderRadius? borderRadius;
  final Widget? trailing;

  const AppSection({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 24),
    this.hasDivider = true,
    this.hasBackground = false,
    this.hasBorder = false,
    this.borderRadius,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.subheading(title),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          // Section content
          if (hasDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
            ),
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: hasBackground
                  ? (isDarkMode ? AppTheme.secondaryColorLight : AppTheme.primaryColorLight)
                  : Colors.transparent,
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              border: hasBorder
                  ? Border.all(
                      color: isDarkMode
                          ? AppTheme.dividerColor
                          : AppTheme.primaryColor.withAlpha(40),
                      width: 1,
                    )
                  : null,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
