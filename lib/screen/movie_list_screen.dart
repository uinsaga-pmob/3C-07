import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/movie.dart';
import 'add_edit_movie_screen.dart';
import 'detail/detail_movie.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _moviesFuture = DatabaseHelper.instance.getAllMovies();
    });
  }

  Future<void> _delete(int id) async {
    await DatabaseHelper.instance.deleteMovie(id);
    _refresh();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Movie deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC79244),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddEditMovieScreen()));
          _refresh(); // reload after add
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies yet. Tap + to add.'));
          }
          final movies = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(movie.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${movie.duration} • ${movie.rating}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFFC79244)),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditMovieScreen(movie: movie),
                            ),
                          );
                          _refresh();
                        },
                      ),
                      // Delete
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _delete(movie.id!),
                      ),
                    ],
                  ),
                  // Tap to open detail
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMovie(
                        title: movie.title,
                        imagePath: movie.imagePath,
                        synopsis: movie.synopsis,
                        cast: movie.cast,
                        duration: movie.duration,
                        rating: movie.rating,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}