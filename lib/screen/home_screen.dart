import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CINETIX',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/logo.png',
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Peaky Blinders & Priest
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Film Populer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMovieCard(
                          imagePath: 'assets/film/peaky_blinders.jpg',
                          title: 'Peaky Blinders',
                          height: 200,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMovieCard(
                          imagePath: 'assets/film/priest.jpg',
                          title: 'Priest',
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Divider
            const Divider(thickness: 2),
            
            // Section 2: Night Has Come & Sweet Home
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Terbaru',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMovieCard(
                          imagePath: 'assets/film/night_has_come.jpg',
                          title: 'Night Has Come',
                          height: 180,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMovieCard(
                          imagePath: 'assets/film/sweet_home.jpg',
                          title: 'Sweet Home',
                          height: 180,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Divider
            const Divider(thickness: 2),
            
            // Section 3: SHOP FOR SIX MILLERS
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rekomendasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturedMovie(
                    imagePath: 'assets/film/six_millers.jpg',
                    title: 'SHOP FOR SIX MILLERS',
                    description: 'Film aksi terbaru dengan cerita yang menegangkan',
                  ),
                ],
              ),
            ),
            
            // Additional Movies Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lainnya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final movies = [
                          {'title': 'Film 1', 'image': 'assets/film/movie1.jpg'},
                          {'title': 'Film 2', 'image': 'assets/film/movie2.jpg'},
                          {'title': 'Film 3', 'image': 'assets/film/movie3.jpg'},
                          {'title': 'Film 4', 'image': 'assets/film/movie4.jpg'},
                          {'title': 'Film 5', 'image': 'assets/film/movie5.jpg'},
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: _buildMovieCard(
                            imagePath: movies[index]['image']!,
                            title: movies[index]['title']!,
                            height: 140,
                            width: 100,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCard({
    required String imagePath,
    required String title,
    required double height,
    double? width,
  }) {
    return GestureDetector(
      onTap: () {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: height,
              width: width,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: height,
                  width: width,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.movie,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedMovie({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha:0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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