import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_model.dart';

class MovieDetailsModel extends MediaDetailsModel<MovieDetails> {
  MovieDetails? get movieDetails => details;

  MovieDetailsModel(super.movieId);

  @override
  Future<MovieDetails> fetchDetailsFromApi(int id, String locale) {
    return apiClient.movieDetails(id, locale);
  }

  @override
  Future<bool> checkFavoriteStatus(int id, String sessionId) {
    return apiClient.isFavorite(id, sessionId);
  }

  @override
  MediaType getMediaType() => MediaType.movie;
}