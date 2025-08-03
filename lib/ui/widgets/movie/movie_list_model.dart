import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/ui/widgets/media_list/media_item_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class MovieListModel extends MediaListModel<Movie, PopularMovieResponse> {
  @override
  MediaItemConfig<Movie> get config => const MovieConfig();

  @override
  Future<PopularMovieResponse> loadPopularItems(int page, String locale) async {
    return await apiClient.popularMovie(page, locale);
  }

  @override
  Future<PopularMovieResponse> searchItems(int page, String locale, String query) async {
    return await apiClient.searchMovie(page, locale, query);
  }

  @override
  List<Movie> extractItemsFromResponse(PopularMovieResponse response) {
    return response.movies;
  }

  @override
  int extractPageFromResponse(PopularMovieResponse response) {
    return response.page;
  }

  @override
  int extractTotalPagesFromResponse(PopularMovieResponse response) {
    return response.totalPages;
  }
}