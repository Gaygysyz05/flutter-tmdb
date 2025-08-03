import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/media_list/media_item_widget.dart';

abstract class MediaListModel<T, R> extends ChangeNotifier {

  final ApiClient _apiClient = ApiClient();
  ApiClient get apiClient => _apiClient;
  final List<T> _items = <T>[];
  late int _currentPage;
  late int _totalPage;
  late bool _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  Timer? searchDebounce;
  late DateFormat _dateFormat;

  MediaItemConfig<T> get config;

  List<T> get items => List.unmodifiable(_items);

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
    _items.clear();
    await _loadNextPage();
  }

  Future<R> loadPopularItems(int page, String locale);
  Future<R> searchItems(int page, String locale, String query);

  List<T> extractItemsFromResponse(R response);
  int extractPageFromResponse(R response);
  int extractTotalPagesFromResponse(R response);

  Future<R> _loadItems(int page, String locale) async {
    if (_searchQuery == null) {
      return await loadPopularItems(page, locale);
    } else {
      return await searchItems(page, locale, _searchQuery!);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final response = await _loadItems(nextPage, _locale);
      _items.addAll(extractItemsFromResponse(response));
      _currentPage = extractPageFromResponse(response);
      _totalPage = extractTotalPagesFromResponse(response);
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
      debugPrint('Error loading items: $e');
    }
  }

  void onItemTap(BuildContext context, int index) {
    if (index >= 0 && index < _items.length) {
      config.onItemTap(context, _items[index], index);
    }
  }

  Future<void> searchMedia(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = query.isNotEmpty ? query : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  void showedItemAtIndex(int index) {
    if (index < _items.length - 1) return;
    _loadNextPage();
  }

  @override
  void dispose() {
    searchDebounce?.cancel();
    super.dispose();
  }
}
