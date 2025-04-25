import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/base_page.dart';
import '../menu/drawer.widget.dart';

class GallerieDetailsPage extends StatefulWidget {
  final String keyword;

  const GallerieDetailsPage(this.keyword, {super.key});

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 0;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  Future<void> getGalleryData(String keyword) async {
    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=$keyword&page=$currentPage&per_page=$size";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          galleryData = json.decode(response.body);
          hits.addAll(galleryData['hits']);
          totalPages = (galleryData['totalHits'] / size).ceil();
          print(hits); // For debugging, as requested
        });
      } else {
        print('Failed to load gallery data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching gallery data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    AppTheme.setThemeMode(isDarkMode); // Sync AppTheme with ThemeProvider

    return BasePage(
      title: totalPages == 0 && galleryData == null
          ? 'Chargement'
          : totalPages == 0
          ? 'Pas de résultats'
          : "${widget.keyword}, Page $currentPage / $totalPages",
      body: galleryData == null
          ? Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: AppTheme.paddingMedium,
              itemCount: hits.length + 1, // +1 for the button at the bottom
              itemBuilder: (context, index) {
                if (index == hits.length) {
                  // Add the "Retour" button at the bottom
                  return FadeInUp(
                    duration: const Duration(milliseconds: 900),
                    child: Padding(
                      padding: AppTheme.paddingMedium,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, size: 20),
                          label: const Text('Retour'),
                          style: AppTheme.primaryButtonStyle.copyWith(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14)),
                            elevation: const MaterialStatePropertyAll(5),
                            shadowColor: MaterialStatePropertyAll(
                                Colors.black.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                var item = hits[index];
                String tags = item['tags'] ?? 'Aucun tag';
                String imageUrl = item['webformatURL'] ?? '';

                return FadeInUp(
                  duration: Duration(milliseconds: 500 + index * 100),
                  child: Column(
                    children: [
                      Container(
                        decoration: AppTheme.cardDecoration.copyWith(
                          color: AppTheme.cardColor
                              .withOpacity(0.85), // Glassmorphic effect
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Padding(
                          padding: AppTheme.paddingMedium,
                          child: Text(
                            tags,
                            style: AppTheme.headingStyle.copyWith(
                              color: AppTheme.textColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: AppTheme.cardDecoration.copyWith(
                          color: AppTheme.cardColor
                              .withOpacity(0.85), // Glassmorphic effect
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(
                                Icons.broken_image,
                                size: 50,
                                color: AppTheme.captionColor,
                              ),
                        )
                            : Icon(
                          Icons.broken_image,
                          size: 50,
                          color: AppTheme.captionColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}