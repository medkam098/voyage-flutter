import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyage/pages/meteo-details.page.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/base_page.dart';
import '../menu/drawer.widget.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  final TextEditingController _villeController = TextEditingController();
  String? _errorText;

  void _rechercherVille() {
    final ville = _villeController.text.trim();
    if (ville.isEmpty) {
      setState(() {
        _errorText = "Veuillez entrer une ville.";
      });
    } else {
      setState(() {
        _errorText = null;
      });
      _onGetMeteoDetails(context);
    }
  }

  void _onGetMeteoDetails(BuildContext context) {
    String ville = _villeController.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(ville),
      ),
    ).then((_) {
      // Clear input only after returning to this page
      _villeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      drawer: const MyDrawer(),
      body: BasePage(
        title: 'Météo',
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: AppTheme.paddingMedium,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consultez la météo',
                style: AppTheme.headingStyle,
              ),
              const SizedBox(height: 8),
              Text(
                'Entrez le nom d\'une ville pour voir les prévisions',
                style: AppTheme.bodyTextStyle.copyWith(
                  color: isDarkMode ? AppTheme.captionColor : AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _villeController,
                decoration: AppTheme.inputDecoration(
                  'Ville',
                  'ex: Paris',
                  Icons.location_city,
                ).copyWith(
                  errorText: _errorText,
                  filled: true,
                  fillColor: isDarkMode ? AppTheme.cardColor : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelStyle: TextStyle(
                    color: isDarkMode ? AppTheme.textColor : AppTheme.textSecondaryColor,
                  ),
                  hintStyle: TextStyle(
                    color: isDarkMode ? AppTheme.captionColor : Colors.grey[600],
                  ),
                ),
                onSubmitted: (_) => _rechercherVille(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Rechercher'),
                  style: AppTheme.primaryButtonStyle,
                  onPressed: _rechercherVille,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _villeController.dispose();
    super.dispose();
  }
}