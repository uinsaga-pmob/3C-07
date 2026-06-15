import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/movie.dart';
import 'detail/detail_movie.dart';
import 'add_edit_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _allMovies = [];
  bool _isLoading = true;

  // Fixed section assignments by title
  final List<String> _popularTitles   = ['Gatotkaca', 'Priest'];
  final List<String> _terbaruTitles   = ['Peaky Blinders', 'Gowok'];
  final List<String> _rekomendasiTitles = ['Bangkitnya Mayit'];
  final List<String> _lainnyaTitles   = ['Pangku', 'Sosok Ketiga', 'Syirik', 'The Nun', 'The Conjuring'];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    await DatabaseHelper.instance.seedMoviesIfEmpty();
    final movies = await DatabaseHelper.instance.getAllMovies();
    setState(() {
      _allMovies = movies;
      _isLoading = false;
    });
  }

  void _refresh() => _loadMovies();

  List<Movie> _getByTitles(List<String> titles) {
    return titles
        .map((t) => _allMovies.where((m) => m.title == t).firstOrNull)
        .whereType<Movie>()
        .toList();
  }



  void _goToDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailMovie(
          movieId: movie.id,
          title: movie.title,
          imagePath: movie.imagePath,
          synopsis: movie.synopsis,
          cast: movie.cast,
          duration: movie.duration,
          rating: movie.rating,
          onDeleted: _refresh,
          onEdited: _refresh,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final popular     = _getByTitles(_popularTitles);
    final terbaru     = _getByTitles(_terbaruTitles);
    final rekomendasi = _getByTitles(_rekomendasiTitles);
    final lainnya     = _getByTitles(_lainnyaTitles);

    // Extra movies added via + button (not in any hardcoded section)
    final knownTitles = [..._popularTitles, ..._terbaruTitles, ..._rekomendasiTitles, ..._lainnyaTitles];
    final extraMovies = _allMovies.where((m) => !knownTitles.contains(m.title)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CINETIX',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset('assets/logo.png', height: 40, width: 40,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.movie, color: Colors.white, size: 40)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Film Populer ──
            if (popular.isNotEmpty)
              _buildSection('Film Populer',
                  Row(children: popular.map((m) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: m == popular.last ? 0 : 12),
                      child: _buildMovieCard(m, height: 200),
                    ),
                  )).toList())),

            if (popular.isNotEmpty) const Divider(thickness: 2),

            // ── Terbaru ──
            if (terbaru.isNotEmpty)
              _buildSection('Terbaru',
                  Row(children: terbaru.map((m) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: m == terbaru.last ? 0 : 12),
                      child: _buildMovieCard(m, height: 180),
                    ),
                  )).toList())),

            if (terbaru.isNotEmpty) const Divider(thickness: 2),

            // ── Rekomendasi ──
            if (rekomendasi.isNotEmpty)
              _buildSection('Rekomendasi',
                  _buildFeaturedMovie(rekomendasi.first)),

            // ── Lainnya ──
            if (lainnya.isNotEmpty)
              _buildSection('Lainnya',
                  SizedBox(
                    height: 190,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: lainnya.map((m) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _buildMovieCard(m, height: 140, width: 100),
                      )).toList(),
                    ),
                  )),

            // ── Extra (user-added) ──
            if (extraMovies.isNotEmpty) ...[
              const Divider(thickness: 2),
              _buildSection('Ditambahkan',
                  Column(children: extraMovies.map((m) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildMovieCard(m, height: 180),
                      )).toList())),
            ],

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildMovieCard(Movie movie, {required double height, double? width}) {
    return GestureDetector(
      onTap: () => _goToDetail(movie),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              movie.imagePath,
              height: height,
              width: width ?? double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Icon(Icons.movie, size: 40, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(movie.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildFeaturedMovie(Movie movie) {
    return GestureDetector(
      onTap: () => _goToDetail(movie),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(movie.imagePath,
                  width: double.infinity, height: 220, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[800],
                      child: const Center(
                          child: Icon(Icons.movie, size: 60, color: Colors.white)))),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withValues(alpha: 210), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              bottom: 20, left: 20, right: 20,
              child: Text(movie.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}