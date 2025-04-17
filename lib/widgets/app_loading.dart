import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A loading indicator with consistent styling for the app
class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;
  final bool isOverlay;

  const AppLoading({
    super.key,
    this.size = 40,
    this.color,
    this.message,
    this.isOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    final loadingColor = color ?? 
        (isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor);

    final loadingWidget = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: 3,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (isOverlay) {
      return Container(
        color: isDarkMode 
            ? Colors.black.withAlpha(150) 
            : Colors.black.withAlpha(100),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              color: isDarkMode ? AppTheme.surfaceColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: loadingWidget,
          ),
        ),
      );
    }

    return Center(child: loadingWidget);
  }
}
