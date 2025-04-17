import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import 'app_text.dart';
import 'app_button.dart';

/// A bottom sheet with consistent styling for the app
class AppBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool isDismissible;
  final bool enableDrag;
  final double? height;
  final bool showCloseButton;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.primaryButtonText,
    this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.isDismissible = true,
    this.enableDrag = true,
    this.height,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      height: height,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.surfaceColor : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDarkMode ? AppTheme.dividerColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.subheading(title),
              if (showCloseButton)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
                    size: 24,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Content
          Flexible(child: child),
          // Buttons
          if (primaryButtonText != null || secondaryButtonText != null) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                if (secondaryButtonText != null)
                  Expanded(
                    child: AppButton(
                      text: secondaryButtonText!,
                      onPressed: onSecondaryButtonPressed ?? () => Navigator.of(context).pop(),
                      isPrimary: false,
                    ),
                  ),
                if (primaryButtonText != null && secondaryButtonText != null)
                  const SizedBox(width: 16),
                if (primaryButtonText != null)
                  Expanded(
                    child: AppButton(
                      text: primaryButtonText!,
                      onPressed: onPrimaryButtonPressed ?? () => Navigator.of(context).pop(),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Show the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    String? primaryButtonText,
    VoidCallback? onPrimaryButtonPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonPressed,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    bool showCloseButton = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AppBottomSheet(
          title: title,
          child: child,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonPressed: onPrimaryButtonPressed,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonPressed: onSecondaryButtonPressed,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          height: height,
          showCloseButton: showCloseButton,
        ),
      ),
    );
  }
}
