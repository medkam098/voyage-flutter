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
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
            showSearch(
              context: context,
              delegate: GallerySearchDelegate(images),
            );
          },
        ),
        PopupMenuButton<String>(
          onSelected: (String value) {
            // Implement filter functionality
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: "all", child: Text("Tous")),
              const PopupMenuItem(value: "nature", child: Text("Nature")),
              const PopupMenuItem(value: "landscape", child: Text("Paysage")),
              const PopupMenuItem(value: "urban", child: Text("Urbain")),
              const PopupMenuItem(
                value: "architecture",
                child: Text("Architecture"),
              ),
            ];
          },
        ),
      ],
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
                    // Show image details when tapped
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
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add new image functionality
          _showAddImageDialog(context);
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showImageDetails(BuildContext context, Map<String, dynamic> image) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Fermer", style: AppTheme.linkTextStyle),
                ),
              ],
            ),
          ),
    );
  }

  void _showAddImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Padding(
              padding: AppTheme.paddingMedium,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ajouter une nouvelle image",
                    style: AppTheme.headingStyle,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: AppTheme.inputDecoration(
                      "Titre",
                      "Entrez le titre de l'image",
                      Icons.title,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: AppTheme.inputDecoration(
                      "Description",
                      "Entrez la description de l'image",
                      Icons.description,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: AppTheme.inputDecoration(
                      "URL de l'image",
                      "Entrez l'URL de l'image",
                      Icons.link,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler", style: AppTheme.linkTextStyle),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Implement save functionality
                          Navigator.of(context).pop();
                        },
                        style: AppTheme.primaryButtonStyle,
                        child: const Text("Enregistrer"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

class GallerySearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> images;

  GallerySearchDelegate(this.images);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        images
            .where(
              (image) =>
                  image["title"].toLowerCase().contains(query.toLowerCase()) ||
                  image["description"].toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  image["category"].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return GridView.builder(
      padding: AppTheme.paddingSmall,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  results[index]["imageUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: AppTheme.paddingSmall,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      results[index]["title"],
                      style: AppTheme.subheadingStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      results[index]["category"],
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
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  // Implementation complete
}
