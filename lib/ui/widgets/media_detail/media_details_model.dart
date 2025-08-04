import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';

abstract class MediaDetailsModel<T> extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  ApiClient get apiClient => _apiClient;

  final int mediaId;
  T? _details;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  T? get details => _details;
  bool get isFavorite => _isFavorite;

  MediaDetailsModel(this.mediaId);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : 'No release date';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _details = await fetchDetailsFromApi(mediaId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await checkFavoriteStatus(mediaId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;
    final newFavorite = !_isFavorite;
    _isFavorite = newFavorite;
    notifyListeners();

    try {
      await _apiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: getMediaType(),
        mediaId: mediaId,
        isFavorite: newFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException e) {
    switch (e.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        debugPrint('Error: ${e.type}');
    }
  }

  Future<T> fetchDetailsFromApi(int id, String locale);
  Future<bool> checkFavoriteStatus(int id, String sessionId);
  MediaType getMediaType();
}