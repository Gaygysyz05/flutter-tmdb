 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/tv_show.dart';
import 'package:themoviedb/domain/entity/popular_tv_show_response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class TVShowListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _tvShows = <TVShow>[];
  late int _currentPage;
  late int _totalPage;
  late bool _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  Timer? searchDebounce;

  List<TVShow> get tvShows => List.unmodifiable(_tvShows);
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : 'No release date';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _tvShows.clear();
    await _loadNextPage();
  }

  Future<PopularTVShowResponse> _loadTVShows(int page, String locale) async {
    if (_searchQuery == null) {
      return await _apiClient.popularTVShow(page, locale);
    } else {
      return await _apiClient.searchTVShow(page, locale, _searchQuery!);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final response = await _loadTVShows(nextPage, _locale);
      _tvShows.addAll(response.tvShows);
      _currentPage = response.page;
      _totalPage = response.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
      debugPrint('Error loading movies: $e');
    }
  }

  void onTVShowTap(BuildContext context, int index) {
    final id = _tvShows[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutesNames.movieDetails,
      arguments: id,
    );
  }

  Future<void> searchTVShow(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 300), () async {
          final searchQuery = query.isNotEmpty ? query : null;
    if (_searchQuery == searchQuery) return;
    _searchQuery = searchQuery;
    await _resetList();
    });
  }

  void showedTVShowAtIndex(int index) {
    if (index < _tvShows.length - 1) return;
    _loadNextPage();
  }
}
