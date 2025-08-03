import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/entity/popular_tv_show_response.dart';
import 'package:themoviedb/domain/entity/tv_show_details.dart';

enum ApiClientExceptionType { network, auth, other, sessionExpired }

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'eeb3849172fe2f258b0565fc7b1da63b';

  static String imageUrl(String path) {
    return '$_imageUrl$path';
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _getPopular<T>(
    MediaType mediaType,
    int page,
    String locale,
    T Function(Map<String, dynamic>) parser,
  ) async {
    final endpoint = '/${mediaType.asString()}/popular';
    
    T wrappedParser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return parser(jsonMap);
    }

    return _get(
      endpoint,
      wrappedParser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
  }

  Future<T> _searchMedia<T>(
    MediaType mediaType,
    int page,
    String locale,
    String query,
    T Function(Map<String, dynamic>) parser,
  ) async {
    final endpoint = '/search/${mediaType.asString()}';
    
    T wrappedParser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return parser(jsonMap);
    }

    return _get(
      endpoint,
      wrappedParser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': false.toString(),
      },
    );
  }

  Future<T> _getMediaDetails<T>(
    MediaType mediaType,
    int mediaId,
    String locale,
    T Function(Map<String, dynamic>) parser, {
    String appendToResponse = 'credits',
  }) async {
    final endpoint = '/${mediaType.asString()}/$mediaId';
    
    T wrappedParser(dynamic json) {
      try {
        final jsonMap = json as Map<String, dynamic>;
        return parser(jsonMap);
      } catch (e) {
        debugPrint('Error parsing ${mediaType.asString()} details: $e');
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }

    return _get(
      endpoint,
      wrappedParser,
      <String, dynamic>{
        'append_to_response': appendToResponse,
        'api_key': _apiKey,
        'language': locale,
      },
    );
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) {
    return _getPopular(
      MediaType.movie,
      page,
      locale,
      PopularMovieResponse.fromJson,
    );
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) {
    return _searchMedia(
      MediaType.movie,
      page,
      locale,
      query,
      PopularMovieResponse.fromJson,
    );
  }

  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  ) {
    return _getMediaDetails(
      MediaType.movie,
      movieId,
      locale,
      MovieDetails.fromJson,
      appendToResponse: 'credits,videos',
    );
  }

  Future<PopularTvShowResponse> popularTVShow(int page, String locale) {
    return _getPopular(
      MediaType.tv,
      page,
      locale,
      PopularTvShowResponse.fromJson,
    );
  }

  Future<PopularTvShowResponse> searchTVShow(
    int page,
    String locale,
    String query,
  ) {
    return _searchMedia(
      MediaType.tv,
      page,
      locale,
      query,
      PopularTvShowResponse.fromJson,
    );
  }

  Future<TvShowDetails> tvShowDetails(
    int tvShowId,
    String locale,
  ) {
    return _getMediaDetails(
      MediaType.tv,
      tvShowId,
      locale,
      TvShowDetails.fromJson,
    );
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get('/authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});

    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
      if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.sessionExpired);
      }
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );

    return result;
  }

  Future<bool> _isFavorite(
    MediaType mediaType,
    int mediaId,
    String sessionId,
  ) async {
    final endpoint = '/${mediaType.asString()}/$mediaId/account_states';
    
    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return jsonMap['favorite'] as bool;
    }

    return _get(
      endpoint,
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );
  }

  Future<bool> isFavorite(int movieId, String sessionId) {
    return _isFavorite(MediaType.movie, movieId, sessionId);
  }

  Future<bool> isFavoriteTvShow(int tvShowId, String sessionId) {
    return _isFavorite(MediaType.tv, tvShowId, sessionId);
  }

  Future<int> _markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };
    
    int parser(dynamic json) {
      return 1;
    }
    
    return _post(
      '/account/$accountId/favorite',
      parameters,
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );
  }

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) {
    return _markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      isFavorite: isFavorite,
    );
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _post('/authentication/token/validate_with_login',
        parameters, parser, <String, dynamic>{'api_key': _apiKey});

    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final result = _post('/authentication/session/new', parameters, parser,
        <String, dynamic>{'api_key': _apiKey});

    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}