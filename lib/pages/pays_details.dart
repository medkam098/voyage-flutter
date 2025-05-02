import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../menu/drawer.widget.dart';

class PaysDetails extends StatefulWidget {
  final String countryName;

  const PaysDetails(this.countryName, {super.key});

  @override
  State<PaysDetails> createState() => _PaysDetailsState();
}

class _PaysDetailsState extends State<PaysDetails> {
  List<dynamic> countries = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  Future<void> fetchCountryData() async {
    final String url = "https://restcountries.com/v2/name/${widget.countryName}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          countries = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    AppTheme.setThemeMode(isDarkMode); // Sync AppTheme with ThemeProvider

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Text(
          widget.countryName,
          style: TextStyle(
            fontSize: 22,
            letterSpacing: 0.5,
            color: isDarkMode ? AppTheme.textColor : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkMode ? AppTheme.textColor : Colors.white,
              size: AppTheme.iconSizeMedium,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        backgroundColor: isDarkMode ? AppTheme.surfaceColor : AppTheme.primaryColor,
        foregroundColor: isDarkMode ? AppTheme.textColor : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? AppTheme.textColor : Colors.white,
        ),
        elevation: isDarkMode ? 1 : 2,
        shadowColor: AppTheme.shadowColor,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          )
              : errorMessage != null
              ? Center(
            child: Text(
              errorMessage!,
              style: AppTheme.bodyTextStyle.copyWith(
                color: AppTheme.captionColor,
              ),
              textAlign: TextAlign.center,
            ),
          )
              : countries.isEmpty
              ? Center(
            child: Text(
              'Aucun pays trouvé',
              style: AppTheme.bodyTextStyle.copyWith(
                color: AppTheme.textColor,
              ),
            ),
          )
              : ListView(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Country name
                      Text(
                        countries[0]['name'] ?? 'Nom inconnu',
                        style: AppTheme.headingStyle.copyWith(
                          color: AppTheme.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Flag
                      countries[0]['flags'] != null && countries[0]['flags']['png'] != null
                          ? Image.network(
                        countries[0]['flags']['png'],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Flag loading error: $error');
                          return Icon(
                            Icons.broken_image,
                            size: 50,
                            color: AppTheme.captionColor,
                          );
                        },
                      )
                          : Icon(
                        Icons.broken_image,
                        size: 50,
                        color: AppTheme.captionColor,
                      ),
                      const SizedBox(height: 16),
                      // Capital
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 20,
                            color: AppTheme.captionColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Capitale: ${countries[0]['capital'] ?? 'Capitale inconnue'}',
                            style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.textColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Population
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 20,
                            color: AppTheme.captionColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Population: ${countries[0]['population'] ?? 0}',
                            style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.textColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Region
                      Row(
                        children: [
                          Icon(
                            Icons.public,
                            size: 20,
                            color: AppTheme.captionColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Région: ${countries[0]['region'] ?? 'Région inconnue'}',
                            style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.textColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Languages
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.language,
                            size: 20,
                            color: AppTheme.captionColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Langues:',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: AppTheme.textColor,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  countries[0]['languages'] != null
                                      ? (countries[0]['languages'] as List)
                                      .map((lang) => lang['name'])
                                      .join(', ')
                                      : 'Inconnu',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: AppTheme.captionColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Currencies
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 20,
                            color: AppTheme.captionColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Devises:',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: AppTheme.textColor,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  countries[0]['currencies'] != null
                                      ? (countries[0]['currencies'] as List)
                                      .map((currency) => currency['name'])
                                      .join(', ')
                                      : 'Inconnu',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: AppTheme.captionColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}