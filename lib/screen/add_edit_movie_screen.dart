import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/movie.dart';

class AddEditMovieScreen extends StatefulWidget {
  final Movie? movie; // null = Add, non-null = Edit

  const AddEditMovieScreen({super.key, this.movie});

  @override
  State<AddEditMovieScreen> createState() => _AddEditMovieScreenState();
}

class _AddEditMovieScreenState extends State<AddEditMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _imageCtrl;
  late TextEditingController _synopsisCtrl;
  late TextEditingController _castCtrl;
  late TextEditingController _durationCtrl;
  late TextEditingController _ratingCtrl;

  bool get _isEditing => widget.movie != null;

  @override
  void initState() {
    super.initState();
    final m = widget.movie;
    _titleCtrl    = TextEditingController(text: m?.title ?? '');
    _imageCtrl    = TextEditingController(text: m?.imagePath ?? '');
    _synopsisCtrl = TextEditingController(text: m?.synopsis ?? '');
    _castCtrl     = TextEditingController(text: m?.cast ?? '');
    _durationCtrl = TextEditingController(text: m?.duration ?? '');
    _ratingCtrl   = TextEditingController(text: m?.rating ?? '');
  }

  @override
  void dispose() {
    for (final c in [_titleCtrl, _imageCtrl, _synopsisCtrl,
                     _castCtrl, _durationCtrl, _ratingCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final movie = Movie(
      id: widget.movie?.id,
      title: _titleCtrl.text.trim(),
      imagePath: _imageCtrl.text.trim(),
      synopsis: _synopsisCtrl.text.trim(),
      cast: _castCtrl.text.trim(),
      duration: _durationCtrl.text.trim(),
      rating: _ratingCtrl.text.trim(),
    );

    if (_isEditing) {
      await DatabaseHelper.instance.updateMovie(movie);
    } else {
      await DatabaseHelper.instance.insertMovie(movie);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Movie' : 'Add Movie'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_titleCtrl,    'Title'),
              _field(_imageCtrl,    'Image Path (assets/...)'),
              _field(_synopsisCtrl, 'Synopsis', maxLines: 4),
              _field(_castCtrl,     'Cast'),
              _field(_durationCtrl, 'Duration (e.g. 2h 15m)'),
              _field(_ratingCtrl,   'Rating (e.g. 13+)'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC79244),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    _isEditing ? 'UPDATE' : 'SAVE',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }
}