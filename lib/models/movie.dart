class Movie {
  final int? id;
  final String title;
  final String imagePath;
  final String synopsis;
  final String cast;
  final String duration;
  final String rating;
  final int updatedAt;

  Movie({
    this.id,
    required this.title,
    required this.imagePath,
    required this.synopsis,
    required this.cast,
    required this.duration,
    required this.rating,
    this.updatedAt = 0,
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
      'updatedAt': updatedAt,
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
    updatedAt: map['updatedAt'] is int
        ? map['updatedAt']
        : int.tryParse(map['updatedAt'].toString()) ?? 0,
  );
}
}