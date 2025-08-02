
import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/tv_show.dart';

part 'popular_tv_show_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularTVShowResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TVShow> tvShows;
  final int totalResults;
  final int totalPages;

  PopularTVShowResponse({
    required this.page,
    required this.tvShows,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularTVShowResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularTVShowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularTVShowResponseToJson(this);
}