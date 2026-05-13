import 'package:flutter/material.dart';

class DetailMovie extends StatelessWidget {
  final String title;
  final String imagePath;
  final String synopsis;
  final String cast;
  final String duration;
  final String rating;

  const DetailMovie({
    super.key,
    required this.title,
    required this.imagePath,
    required this.synopsis,
    required this.cast,
    required this.duration,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    // Parse rating string to a numeric score for the circle (e.g. "13+" -> 7.5)
    final double ratingScore = _parseRatingScore(rating);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
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
            // ── Top section: Poster (left) + Info (right) ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 130,
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.movie, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title + info badges
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        // Info badges row
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildInfoBadge('HD'),
                            _buildInfoText(duration),
                            _buildInfoText(rating),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Cast preview
                        Text(
                          cast,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
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

            // ── Rating & Action Icons Row ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 228, 228),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Rating circle
                    _buildRatingCircle(ratingScore),
                    const Spacer(),
                    // Like / Dislike
                    Row(
                      children: [
                        const Icon(Icons.thumb_up_outlined, color: Colors.black54, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '250',
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                        const SizedBox(width: 14),
                        const Icon(Icons.thumb_down_outlined, color: Colors.black54, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Synopsis ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    synopsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Cast Section ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cast',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cast,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ── Buttons ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(199, 251, 251, 251),
                        foregroundColor: const Color(0xFFC79244),
                        side: const BorderSide(color: Color(0xFFC79244), width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.play_circle_outline),
                      label: const Text(
                        'TRAILER',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC79244),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'BELI TIKET',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Helper Widgets ──

  Widget _buildInfoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildRatingCircle(double score) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: score / 10,
            strokeWidth: 3,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              score >= 7
                  ? const Color(0xFFC79244) // gold for good
                  : score >= 5
                      ? Colors.orange
                      : Colors.red,
            ),
          ),
          Text(
            score.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback? onTap, [Color color = Colors.black54]) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: color, size: 22),
    );
  }

  double _parseRatingScore(String rating) {
    // Try to parse as a number directly
    final numMatch = RegExp(r'[\d.]+').firstMatch(rating);
    if (numMatch != null) {
      final parsed = double.tryParse(numMatch.group(0)!);
      if (parsed != null) {
        // If it looks like an age rating (13+, 17+), map to a score
        if (rating.contains('+')) {
          if (parsed >= 17) return 8.0;
          if (parsed >= 13) return 7.5;
          return 7.0;
        }
        // Otherwise use as-is (clamped to 10)
        return parsed.clamp(0, 10).toDouble();
      }
    }
    return 7.0; // default
  }
}