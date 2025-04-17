import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

/// A custom text input field with consistent styling for the app
class AppInputField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;

  const AppInputField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.autofocus = false,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
              letterSpacing: 0.2,
            ),
          ),
        ),
        // Input field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          autofocus: autofocus,
          focusNode: focusNode,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            color: isDarkMode ? AppTheme.textColor : AppTheme.secondaryColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              color: isDarkMode 
                ? AppTheme.textSecondaryColor.withAlpha(180) 
                : AppTheme.textSecondaryColor,
            ),
            contentPadding: contentPadding ?? 
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: isDarkMode ? AppTheme.secondaryColorLight : Colors.white,
            prefixIcon: prefixIcon != null ? Icon(
              prefixIcon,
              color: isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor,
              size: 20,
            ) : null,
            suffixIcon: suffixIcon != null ? IconButton(
              icon: Icon(
                suffixIcon,
                color: isDarkMode ? AppTheme.primaryColor : AppTheme.primaryColor,
                size: 20,
              ),
              onPressed: onSuffixIconPressed,
            ) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? AppTheme.dividerColor : AppTheme.dividerColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.errorColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.errorColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
