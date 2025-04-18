import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';

class GalleriePage extends StatelessWidget {
  const GalleriePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the gallery
    final List<Map<String, dynamic>> images = [
      {
        "title": "Beach Sunset",
        "description": "Beautiful sunset at the beach",
        "imageUrl": "https://picsum.photos/200/300?random=1",
        "category": "Nature",
      },
      {
        "title": "Mountain View",
        "description": "Scenic mountain landscape",
        "imageUrl": "https://picsum.photos/200/300?random=2",
        "category": "Landscape",
      },
      {
        "title": "City Lights",
        "description": "Night city skyline",
        "imageUrl": "https://picsum.photos/200/300?random=3",
        "category": "Urban",
      },
      {
        "title": "Forest Path",
        "description": "Path through dense forest",
        "imageUrl": "https://picsum.photos/200/300?random=4",
        "category": "Nature",
      },
      {
        "title": "Desert Dunes",
        "description": "Sandy dunes at sunset",
        "imageUrl": "https://picsum.photos/200/300?random=5",
        "category": "Landscape",
      },
      {
        "title": "Ancient Architecture",
        "description": "Historic building facade",
        "imageUrl": "https://picsum.photos/200/300?random=6",
        "category": "Architecture",
      },
    ];

    return BasePage(
      title: "Galerie",
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: AppTheme.paddingSmall,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showImageDetails(context, images[index]);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            images[index]["imageUrl"],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: AppTheme.paddingSmall,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                images[index]["title"],
                                style: AppTheme.subheadingStyle.copyWith(
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                images[index]["category"],
                                style: TextStyle(
                                  color: AppTheme.captionColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDetails(BuildContext context, Map<String, dynamic> image) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(image["imageUrl"], fit: BoxFit.cover),
            Padding(
              padding: AppTheme.paddingMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(image["title"], style: AppTheme.headingStyle),
                  const SizedBox(height: 8),
                  Text(image["description"], style: AppTheme.bodyTextStyle),
                  const SizedBox(height: 8),
                  Text(
                    "Catégorie: ${image["category"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.captionColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}