import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyage/pages/pays_details.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/base_page.dart';
import '../menu/drawer.widget.dart';

class PaysPage extends StatefulWidget {
  const PaysPage({super.key});

  @override
  State<PaysPage> createState() => _PaysPageState();
}

class _PaysPageState extends State<PaysPage> {
  final TextEditingController _countryNameController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  void _rechercherPays() async {
    final countryName = _countryNameController.text.trim();
    if (countryName.isEmpty) {
      setState(() {
        _errorText = "Veuillez entrer un nom de pays.";
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
      await _onGetPaysDetails(context);
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

  Future<void> _onGetPaysDetails(BuildContext context) async {
    String countryName = _countryNameController.text.trim();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaysDetails(countryName),
      ),
    );
    _countryNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      drawer: const MyDrawer(),
      body: BasePage(
        title: 'Pays',
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: AppTheme.paddingMedium,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rechercher un pays',
                style: AppTheme.headingStyle,
              ),
              const SizedBox(height: 8),
              Text(
                'Entrez un nom de pays pour rechercher des informations',
                style: AppTheme.bodyTextStyle.copyWith(
                  color: isDarkMode ? AppTheme.captionColor : AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _countryNameController,
                decoration: AppTheme.inputDecoration(
                  'Nom Pays',
                  'ex: Tunisia',
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
                  suffixIcon: _countryNameController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _countryNameController.clear();
                      setState(() {
                        _errorText = null;
                      });
                    },
                  )
                      : null,
                ),
                onSubmitted: (_) => _rechercherPays(),
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
                  onPressed: _isLoading ? null : _rechercherPays,
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
    _countryNameController.dispose();
    super.dispose();
  }
}