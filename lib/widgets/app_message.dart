import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A message widget with consistent styling for the app
class AppMessage extends StatelessWidget {
  final String message;
  final MessageType type;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final bool isDismissible;

  const AppMessage.success({
    super.key,
    required this.message,
    this.icon = Icons.check_circle,
    this.onDismiss,
    this.isDismissible = true,
  }) : type = MessageType.success;

  const AppMessage.error({
    super.key,
    required this.message,
    this.icon = Icons.error,
    this.onDismiss,
    this.isDismissible = true,
  }) : type = MessageType.error;

  const AppMessage.info({
    super.key,
    required this.message,
    this.icon = Icons.info,
    this.onDismiss,
    this.isDismissible = true,
  }) : type = MessageType.info;

  const AppMessage.warning({
    super.key,
    required this.message,
    this.icon = Icons.warning,
    this.onDismiss,
    this.isDismissible = true,
  }) : type = MessageType.warning;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    Color backgroundColor;
    Color iconColor;
    Color textColor;

    switch (type) {
      case MessageType.success:
        backgroundColor = isDarkMode 
            ? const Color(0xFF1B5E20).withAlpha(80) 
            : const Color(0xFFE8F5E9);
        iconColor = isDarkMode 
            ? const Color(0xFF81C784) 
            : const Color(0xFF2E7D32);
        textColor = isDarkMode 
            ? const Color(0xFFE8F5E9) 
            : const Color(0xFF1B5E20);
        break;
      case MessageType.error:
        backgroundColor = isDarkMode 
            ? const Color(0xFFB71C1C).withAlpha(80) 
            : const Color(0xFFFFEBEE);
        iconColor = isDarkMode 
            ? const Color(0xFFEF9A9A) 
            : const Color(0xFFB71C1C);
        textColor = isDarkMode 
            ? const Color(0xFFFFEBEE) 
            : const Color(0xFFB71C1C);
        break;
      case MessageType.info:
        backgroundColor = isDarkMode 
            ? const Color(0xFF01579B).withAlpha(80) 
            : const Color(0xFFE1F5FE);
        iconColor = isDarkMode 
            ? const Color(0xFF81D4FA) 
            : const Color(0xFF0277BD);
        textColor = isDarkMode 
            ? const Color(0xFFE1F5FE) 
            : const Color(0xFF01579B);
        break;
      case MessageType.warning:
        backgroundColor = isDarkMode 
            ? const Color(0xFFE65100).withAlpha(80) 
            : const Color(0xFFFFF3E0);
        iconColor = isDarkMode 
            ? const Color(0xFFFFCC80) 
            : const Color(0xFFEF6C00);
        textColor = isDarkMode 
            ? const Color(0xFFFFF3E0) 
            : const Color(0xFFE65100);
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 15,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),
            if (isDismissible && onDismiss != null)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: textColor.withAlpha(180),
                  size: 18,
                ),
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}

enum MessageType {
  success,
  error,
  info,
  warning,
}
