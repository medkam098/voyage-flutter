import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BasePage(
      title: "Paramètres",
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: AppTheme.primaryColor),
            title: Text("Langue", style: AppTheme.bodyTextStyle),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: AppTheme.primaryColor),
            title: Text("Thème sombre", style: AppTheme.bodyTextStyle),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: AppTheme.primaryColor),
            title: Text("Notifications", style: AppTheme.bodyTextStyle),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
            ),
          ),
          // Information about the theme
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("À propos du thème", style: AppTheme.subheadingStyle),
                    const SizedBox(height: 8),
                    Text(
                      "Le thème sombre réduit la fatigue oculaire dans les environnements peu éclairés et économise la batterie sur les appareils avec écran OLED.",
                      style: AppTheme.bodyTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
