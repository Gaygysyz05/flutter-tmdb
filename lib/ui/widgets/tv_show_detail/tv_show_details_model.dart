import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/tv_show_details.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_model.dart';

class TvShowDetailsModel extends MediaDetailsModel<TvShowDetails> {
  TvShowDetails? get tvShowDetails => details;

  TvShowDetailsModel(super.tvShowId);

  @override
  Future<TvShowDetails> fetchDetailsFromApi(int id, String locale) {
    return apiClient.tvShowDetails(id, locale);
  }

  @override
  Future<bool> checkFavoriteStatus(int id, String sessionId) {
    return apiClient.isFavoriteTvShow(id, sessionId);
  }

  @override
  MediaType getMediaType() => MediaType.tv;
}