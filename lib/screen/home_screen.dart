import 'package:flutter/material.dart';
import 'detail/detail_movie.dart';

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
                return const Icon(Icons.movie, color: Colors.white, size: 40);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Film Populer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Film Populer',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                          movieId: 'priest',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 2),

            // Section 2: Terbaru
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Terbaru',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMovieCard(
                          context: context,
                          imagePath: 'assets/film/peakblinders.png',
                          title: 'Peaky Blinders',
                          height: 180,
                          movieId: 'peakblinders',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMovieCard(
                          context: context,
                          imagePath: 'assets/film/Gowok.jpg',
                          title: 'Gowok',
                          height: 180,
                          movieId: 'gowok',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 2),

            // Section 3: Rekomendasi
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rekomendasi',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildFeaturedMovie(
                    context: context,
                    imagePath: 'assets/film/Bangkitnya mayit.jpg',
                    title: 'Bangkitnya Mayit',
                    description: 'Film aksi terbaru dengan cerita yang menegangkan',
                    movieId: 'bangkitnya',
                  ),
                ],
              ),
            ),

            // Section 4: Lainnya
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lainnya',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final movies = [
                          {'title': 'Pangku',       'image': 'assets/film/Pangku.jpg',        'id': 'pangku'},
                          {'title': 'Sosok Ketiga', 'image': 'assets/film/Sosok ketiga.jpg',  'id': 'ketiga'},
                          {'title': 'Syirik',       'image': 'assets/film/Syirik.jpg',        'id': 'syirik'},
                          {'title': 'The Nun',      'image': 'assets/film/The nun.jpg',       'id': 'nun'},
                          {'title': 'The Conjuring','image': 'assets/film/The conjuring.jpg', 'id': 'conjuring'},
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
      onTap: () => _navigateToMovieDetail(context, movieId, title, imagePath),
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
                  child: const Icon(Icons.movie, size: 40, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
      onTap: () => _navigateToMovieDetail(context, movieId, title, imagePath),
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
                      child: Icon(Icons.movie, size: 60, color: Colors.white),
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
                    Colors.black.withValues(alpha: 204),
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
                  Text(title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(description,
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Single navigate function — accepts title & imagePath
 void _navigateToMovieDetail(BuildContext context, String movieId, String title, String imagePath) {
  // Movie data map
  final movieData = {
    'gatotkaca': {
      'synopsis': 'Baru beberapa hari tinggal di apartemen...',
      'cast': 'Rizky Nazar, Yuki Kato',
      'duration': '119 minutes',
      'rating': '13+',
    },
    'nun': {
      'synopsis': 'A priest investigates the haunting of a Romanian monastery...',
      'cast': 'Taissa Farmiga, Demián Bichir',
      'duration': '96 minutes',
      'rating': '17+',
    },
    'priest': {
      'synopsis': 'A priest lives in a dystopian world ruled by the church...',
      'cast': 'Paul Bettany, Karl Urban',
      'duration': '87 minutes',
      'rating': '13+',
    },
    // add the rest of your movies here...
  };

  final data = movieData[movieId];

  Navigator.push(context, MaterialPageRoute(
    builder: (context) => DetailMovie(
      title: title,
      imagePath: imagePath,
      synopsis: data?['synopsis'] ?? 'Sinopsis belum tersedia.',
      cast: data?['cast'] ?? 'Belum tersedia.',
      duration: data?['duration'] ?? '-',
      rating: data?['rating'] ?? '-',
    ),
  ));
}

  // ✅ Single default detail page — uses title & imagePath correctly
  Widget _buildDefaultDetailPage(
      BuildContext context, String title, String imagePath) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Icon(Icons.movie, size: 100, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  const Text(
                    'Detail film akan ditampilkan di sini.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
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