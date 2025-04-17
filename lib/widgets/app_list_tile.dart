import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A custom list tile with consistent styling for the app
class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final bool hasDivider;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: leadingIcon != null
              ? Icon(
                  leadingIcon,
                  color: isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor,
                  size: 24,
                )
              : null,
          title: Text(
            title,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
              letterSpacing: 0.2,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 14,
                    color: isDarkMode
                        ? AppTheme.textSecondaryColor
                        : AppTheme.textSecondaryColor,
                  ),
                )
              : null,
          trailing: trailingIcon != null
              ? Icon(
                  trailingIcon,
                  color: isDarkMode
                      ? AppTheme.textSecondaryColor
                      : AppTheme.textSecondaryColor,
                  size: 20,
                )
              : null,
          onTap: onTap,
        ),
        if (hasDivider)
          Divider(
            color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
            height: 1,
            indent: leadingIcon != null ? 56 : 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
