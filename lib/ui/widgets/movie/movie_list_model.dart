import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';

  String stringFromDate(DateTime? date) {
    if (date == null) return 'No release date';
    return _dateFormat.format(date);
  }

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final response = await _apiClient.popularMovie(1, _locale);
      _movies.addAll(response.movies);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching popular movies: $e');
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutesNames.movieDetails,
      arguments: id,
    );
  }
}
