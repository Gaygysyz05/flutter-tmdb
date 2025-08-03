import 'package:themoviedb/domain/entity/tv_show.dart';
import 'package:themoviedb/domain/entity/popular_tv_show_response.dart';
import 'package:themoviedb/ui/widgets/media_list/media_item_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class TvShowListModel extends MediaListModel<TvShow, PopularTvShowResponse> {
  @override
  MediaItemConfig<TvShow> get config => const TvShowConfig();

  @override
  Future<PopularTvShowResponse> loadPopularItems(
      int page, String locale) async {
    return await apiClient.popularTVShow(page, locale);
  }

  @override
  Future<PopularTvShowResponse> searchItems(
      int page, String locale, String query) async {
    return await apiClient.searchTVShow(page, locale, query);
  }

  @override
  List<TvShow> extractItemsFromResponse(PopularTvShowResponse response) {
    return response.tvShows;
  }

  @override
  int extractPageFromResponse(PopularTvShowResponse response) {
    return response.page;
  }

  @override
  int extractTotalPagesFromResponse(PopularTvShowResponse response) {
    return response.totalPages;
  }
}
