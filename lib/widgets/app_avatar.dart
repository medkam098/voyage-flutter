import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A custom avatar widget with consistent styling for the app
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2,
    this.onTap,
  }) : assert(imageUrl != null || initials != null, 'Either imageUrl or initials must be provided');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    final avatarBorderColor = borderColor ?? 
        (isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor);
    
    final avatarBackgroundColor = backgroundColor ?? 
        (isDarkMode ? AppTheme.secondaryColorLight : AppTheme.primaryColorLight);

    Widget avatarContent;
    if (imageUrl != null) {
      avatarContent = CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: avatarBackgroundColor,
      );
    } else {
      avatarContent = CircleAvatar(
        radius: size / 2,
        backgroundColor: avatarBackgroundColor,
        child: Text(
          initials!,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppTheme.textColor : AppTheme.primaryColor,
          ),
        ),
      );
    }

    final avatar = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: avatarBorderColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: avatarContent,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: avatar,
      );
    }

    return avatar;
  }
}
