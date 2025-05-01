import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
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

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Text(
          totalPages == 0 && galleryData == null
              ? 'Chargement'
              : totalPages == 0
              ? 'Pas de résultats'
              : "${widget.keyword}, Page $currentPage / $totalPages",
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
          child: galleryData == null
              ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          )
              : ListView.builder(
            controller: _scrollController,
            padding: AppTheme.paddingMedium,
            itemCount: hits.length,
            itemBuilder: (context, index) {
              var item = hits[index];
              // Extract tags and limit to 3
              String tags = item['tags'] ?? 'Aucun tag';
              List<String> tagList = tags.split(',').map((tag) => tag.trim()).toList();
              List<String> displayTags = tagList.take(3).toList();
              // Extract additional information
              int likes = item['likes'] ?? 0;
              int comments = item['comments'] ?? 0;
              int views = item['views'] ?? 0;
              int downloads = item['downloads'] ?? 0;
              String imageUrl = item['webformatURL'] ?? '';

              return FadeInUp(
                duration: Duration(milliseconds: 500 + index * 100),
                child: Column(
                  children: [
                    Container(
                      decoration: AppTheme.cardDecoration.copyWith(
                        color: AppTheme.cardColor.withOpacity(0.9),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        children: [
                          // Image with gradient overlay
                          Stack(
                            children: [
                              imageUrl.isNotEmpty
                                  ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220,
                                errorBuilder: (context, error, stackTrace) => Icon(
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
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Additional information with background
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              color: Colors.black.withOpacity(0.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: Colors.redAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$likes',
                                        style: AppTheme.captionStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        size: 16,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$comments',
                                        style: AppTheme.captionStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 16,
                                        color: Colors.greenAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$views',
                                        style: AppTheme.captionStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.download,
                                        size: 16,
                                        color: Colors.orangeAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$downloads',
                                        style: AppTheme.captionStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tags as badges
                          FadeInUp(
                            duration: const Duration(milliseconds: 700),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Wrap(
                                spacing: 8, // Space between badges
                                children: displayTags.map((tag) => Chip(
                                  label: Text(
                                    tag,
                                    style: AppTheme.captionStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  elevation: 2,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}