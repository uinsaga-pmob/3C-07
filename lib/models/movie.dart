class Movie {
  final int? id;
  final String title;
  final String imagePath;
  final String synopsis;
  final String cast;
  final String duration;
  final String rating;

  Movie({
    this.id,
    required this.title,
    required this.imagePath,
    required this.synopsis,
    required this.cast,
    required this.duration,
    required this.rating,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'synopsis': synopsis,
      'cast': cast,
      'duration': duration,
      'rating': rating,
    };
  }

  // Create from Map (SQLite row)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      synopsis: map['synopsis'],
      cast: map['cast'],
      duration: map['duration'],
      rating: map['rating'],
    );
  }
}