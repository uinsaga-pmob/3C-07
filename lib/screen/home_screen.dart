import 'package:flutter/material.dart';
import 'detail/detail_gatotkaca.dart'; // Import halaman detail Gatotkaca

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
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.movie,
                  color: Colors.white,
                  size: 40,
                );
              },
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
                          context: context,
                          imagePath: 'assets/film/Gatotkaca.jpg',
                          title: 'Gatotkaca',
                          height: 200,
                          movieId: 'gatotkaca',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMovieCard(
                          context: context,
                          imagePath: 'assets/film/priest.png',
                          title: 'Priest',
                          height: 200,
                          movieId: 'gatotkaca',
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
                          context: context,
                          imagePath: 'assets/film/peakblinders.png',
                          title: 'Peaky blinders',
                          height: 180,
                          movieId: 'gatotkaca',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMovieCard(
                          context: context,
                          imagePath: 'assets/film/Gowok.jpg',
                          title: 'Gowok',
                          height: 180,
                          movieId: 'gatotkaca',
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
                    context: context,
                    imagePath: 'assets/film/Bangkitnya mayit.jpg',
                    title: 'Bangkitnya mayit',
                    description: 'Film aksi terbaru dengan cerita yang menegangkan',
                    movieId: 'gatotkaca',
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
                          {
                            'title': 'Pangku', 
                            'image': 'assets/film/Pangku.jpg',
                            'id': 'gatotkaca'
                          },
                          {
                            'title': 'Sosok ketiga', 
                            'image': 'assets/film/Sosok ketiga.jpg',
                            'id': 'gatotkaca'
                          },
                          {
                            'title': 'Syirik', 
                            'image': 'assets/film/Syirik.jpg',
                            'id': 'gatotkaca'
                          },
                          {
                            'title': 'The nun', 
                            'image': 'assets/film/The nun.jpg',
                            'id': 'gatotkaca'
                          },
                          {
                            'title': 'The conjuring', 
                            'image': 'assets/film/The conjuring.jpg',
                            'id': 'gatotkaca'
                          },
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: _buildMovieCard(
                            context: context,
                            imagePath: movies[index]['image']!,
                            title: movies[index]['title']!,
                            height: 140,
                            width: 100,
                            movieId: movies[index]['id']!,
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
    required BuildContext context,
    required String imagePath,
    required String title,
    required double height,
    double? width,
    required String movieId,
  }) {
    return GestureDetector(
      onTap: () {
        _navigateToMovieDetail(context, movieId);
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
    required BuildContext context,
    required String imagePath,
    required String title,
    required String description,
    required String movieId,
  }) {
    return GestureDetector(
      onTap: () {
        _navigateToMovieDetail(context, movieId);
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
                    Colors.black.withValues(alpha: 204), // 0.8 opacity = 204/255
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

  // Fungsi untuk navigasi ke halaman detail berdasarkan movieId
  void _navigateToMovieDetail(BuildContext context, String movieId) {
    switch (movieId) {
      case 'gatotkaca':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailGatotkaca(),
          ),
        );
        break;
      default:
        // Untuk film lain, gunakan halaman detail default
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _buildDefaultDetailPage(context, movieId),
          ),
        );
        break;
    }
  }

  // Halaman detail default untuk film yang belum memiliki halaman khusus
  // Tambahkan parameter BuildContext
  Widget _buildDefaultDetailPage(BuildContext context, String movieId) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Movie Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.movie,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieId.replaceAll('_', ' ').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Detail film akan ditampilkan di sini.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
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