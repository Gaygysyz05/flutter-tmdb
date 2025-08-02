import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie_date_parser.dart';

part 'tv_show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TVShow {
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalName;
  final String originalLanguage;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final double voteAverage;

  TVShow({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalName,
    required this.originalLanguage,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) => _$TVShowFromJson(json);

  Map<String, dynamic> toJson() => _$TVShowToJson(this);
}
