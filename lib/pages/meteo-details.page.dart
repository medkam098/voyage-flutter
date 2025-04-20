import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/base_page.dart';
import '../menu/drawer.widget.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  const MeteoDetailsPage(this.ville, {super.key});

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  List<dynamic>? _forecastData;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final apiKey = 'c109c07bc4df77a88c923e6407aef864';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=${widget.ville}&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Filtrer pour 3 jours (72 heures, environ 24 entrées)
        final now = DateTime.now();
        final threeDaysLater = now.add(const Duration(days: 3));
        final filteredData = data['list'].where((forecast) {
          final forecastTime =
          DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
          return forecastTime.isBefore(threeDaysLater);
        }).toList();

        setState(() {
          _forecastData = filteredData;
          _isLoading = false;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Ville non trouvée ou erreur API.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion : $e';
        _isLoading = false;
      });
    }
  }

  String _getWeatherIcon(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return 'images/clear.png';
      case 'rain':
        return 'images/rain.png';
      case 'clouds':
        return 'images/clouds.png';
      case 'snow':
        return 'images/snow.png';
      default:
        return 'images/meteo.png';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    return '$day/$month à ${hour}h';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      drawer: const MyDrawer(),
      body: BasePage(
        title: 'Météo à ${widget.ville}',
        body: Padding(
          padding: AppTheme.paddingMedium,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _errorMessage!,
                  style: AppTheme.bodyTextStyle.copyWith(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Retour'),
                  style: AppTheme.primaryButtonStyle,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prévisions pour ${widget.ville}',
                  style: AppTheme.headingStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Détails du météo',
                  style: AppTheme.bodyTextStyle.copyWith(
                    color: isDarkMode
                        ? AppTheme.captionColor
                        : AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                ...?_forecastData?.map((forecast) {
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      forecast['dt'] * 1000);
                  final temp = forecast['main']['temp'].toStringAsFixed(1);
                  final weatherMain = forecast['weather'][0]['main'];
                  final humidity = forecast['main']['humidity'];
                  final windSpeed = forecast['wind']['speed'];

                  return Card(
                    color: isDarkMode
                        ? AppTheme.cardColor
                        : Colors.grey[100],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            _getWeatherIcon(weatherMain),
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatDateTime(dateTime),
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$temp°C',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: isDarkMode
                                        ? AppTheme.captionColor
                                        : AppTheme.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Humidité : $humidity%',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: isDarkMode
                                        ? AppTheme.captionColor
                                        : AppTheme.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Vent : $windSpeed m/s',
                                  style: AppTheme.bodyTextStyle.copyWith(
                                    color: isDarkMode
                                        ? AppTheme.captionColor
                                        : AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Retour'),
                    style: AppTheme.primaryButtonStyle,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}