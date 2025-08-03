import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/tv_show.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';


abstract class MediaItemConfig<T> {
  const MediaItemConfig();
  
  String getTitle(T item);
  DateTime? getReleaseDate(T item);
  String getOverview(T item);
  String? getPosterPath(T item);
  int getId(T item);

  void onItemTap(BuildContext context, T item, int index);
}

class MovieConfig extends MediaItemConfig<Movie> {
  const MovieConfig();
  
  @override
  String getTitle(Movie item) => item.title;
  
  @override
  DateTime? getReleaseDate(Movie item) => item.releaseDate;
  
  @override
  String getOverview(Movie item) => item.overview;
  
  @override
  String? getPosterPath(Movie item) => item.posterPath;
  
  @override
  int getId(Movie item) => item.id;
  
  @override
  void onItemTap(BuildContext context, Movie item, int index) {
    Navigator.of(context).pushNamed(
      MainNavigationRoutesNames.movieDetails,
      arguments: item.id,
    );
  }
}

class TvShowConfig extends MediaItemConfig<TvShow> {
  const TvShowConfig();
  
  @override
  String getTitle(TvShow item) => item.name;
  
  @override
  DateTime? getReleaseDate(TvShow item) => item.firstAirDate;
  
  @override
  String getOverview(TvShow item) => item.overview;
  
  @override
  String? getPosterPath(TvShow item) => item.posterPath;
  
  @override
  int getId(TvShow item) => item.id;
  
  @override
  void onItemTap(BuildContext context, TvShow item, int index) {
    Navigator.of(context).pushNamed(
      MainNavigationRoutesNames.tvShowDetails,
      arguments: item.id,
    );
  }
}