import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A chip widget with consistent styling for the app
class AppChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;

  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    this.onTap,
    this.onDelete,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    final chipBackgroundColor = isSelected
        ? (selectedBackgroundColor ??
            (isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor))
        : (backgroundColor ??
            (isDarkMode ? AppTheme.secondaryColorLight : AppTheme.primaryColorLight));

    final chipTextColor = isSelected
        ? (selectedTextColor ?? Colors.white)
        : (textColor ??
            (isDarkMode ? AppTheme.textColor : AppTheme.primaryColor));

    return RawChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: chipTextColor,
        ),
      ),
      avatar: icon != null
          ? Icon(
              icon,
              size: 18,
              color: chipTextColor,
            )
          : null,
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: onDelete,
      onPressed: onTap,
      selected: isSelected,
      backgroundColor: chipBackgroundColor,
      selectedColor: selectedBackgroundColor ??
          (isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? Colors.transparent
              : (isDarkMode
                  ? AppTheme.dividerColor
                  : AppTheme.primaryColor.withAlpha(50)),
          width: 1,
        ),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }
}
