import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyage/pages/gallerie-details.page.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/base_page.dart';
import '../menu/drawer.widget.dart';

class GalleriePage extends StatefulWidget {
  const GalleriePage({super.key});

  @override
  State<GalleriePage> createState() => _GalleriePageState();
}

class _GalleriePageState extends State<GalleriePage> {
  final TextEditingController _keywordController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  void _rechercherPhotos() async {
    final keyword = _keywordController.text.trim();
    if (keyword.isEmpty) {
      setState(() {
        _errorText = "Veuillez entrer un mot-clé.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await _onGetGallerieDetails(context);
    } catch (e) {
      setState(() {
        _errorText = "Erreur lors de la recherche. Veuillez réessayer.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onGetGallerieDetails(BuildContext context) async {
    String keyword = _keywordController.text.trim();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailsPage(keyword),
      ),
    );
    _keywordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      drawer: const MyDrawer(),
      body: BasePage(
        title: 'Galerie',
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: AppTheme.paddingMedium,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rechercher des photos',
                style: AppTheme.headingStyle,
              ),
              const SizedBox(height: 8),
              Text(
                'Entrez un mot-clé pour rechercher des photos',
                style: AppTheme.bodyTextStyle.copyWith(
                  color: isDarkMode ? AppTheme.captionColor : AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _keywordController,
                decoration: AppTheme.inputDecoration(
                  'Mot-clé',
                  'ex: Nature',
                  Icons.search,
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
                  suffixIcon: _keywordController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _keywordController.clear();
                      setState(() {
                        _errorText = null;
                      });
                    },
                  )
                      : null,
                ),
                onSubmitted: (_) => _rechercherPhotos(),
                onChanged: (_) => setState(() {
                  _errorText = null;
                }),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: _isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.search),
                  label: Text(_isLoading ? 'Recherche...' : 'Rechercher'),
                  style: AppTheme.primaryButtonStyle,
                  onPressed: _isLoading ? null : _rechercherPhotos,
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
    _keywordController.dispose();
    super.dispose();
  }
}