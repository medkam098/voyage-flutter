import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import 'app_text.dart';
import 'app_button.dart';

/// An empty state widget with consistent styling for the app
class AppEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double iconSize;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.buttonText,
    this.onButtonPressed,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: isDarkMode ? AppTheme.primaryColor.withAlpha(180) : AppTheme.primaryColor.withAlpha(180),
            ),
            const SizedBox(height: 24),
            AppText.subheading(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            AppText.body(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? AppTheme.textSecondaryColor : AppTheme.textSecondaryColor,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              AppButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
