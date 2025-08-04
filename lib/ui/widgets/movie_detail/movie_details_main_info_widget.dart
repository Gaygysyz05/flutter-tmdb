import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaInfoWidget<MovieDetailsModel>(
      getOverview: (model) => model?.movieDetails?.overview,
      getBackdropPath: (model) => model?.movieDetails?.backdropPath,
      getPosterPath: (model) => model?.movieDetails?.posterPath,
      getTitle: (model) => model?.movieDetails?.title,
      getYear: (model) => model?.movieDetails?.releaseDate?.year,
      getUserScore: (model) => model?.movieDetails?.voteAverage.toDouble() ?? 0.0,
      buildScoreExtraWidget: (context, model) => _buildMovieTrailerWidget(context, model),
      getSummaryTexts: _getMovieSummaryTexts,
      getCrew: (model) => model?.movieDetails?.credits.crew,
    );
  }

  Widget _buildMovieTrailerWidget(BuildContext context, MovieDetailsModel? model) {
    final videos = model?.movieDetails?.videos.results
        .where((video) => video.site == 'YouTube' && video.type == 'Trailer');
    final trailerKey = videos?.isNotEmpty == true ? videos!.first.key : null;
    
    return trailerKey != null
        ? TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              MainNavigationRoutesNames.movieTrailer,
              arguments: trailerKey,
            ),
            child: const Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.blue),
                SizedBox(width: 5),
                Text('Play Trailer', style: TextStyle(color: Colors.blue)),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  List<String> _getMovieSummaryTexts(MovieDetailsModel? model) {
    var texts = <String>[];
    if (model == null) return texts;

    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final originCountry = model.movieDetails?.originCountry;
    if (originCountry != null && originCountry.isNotEmpty) {
      texts.add('(${originCountry[0]})');
    }

    final runtime = model.movieDetails?.runtime;
    if (runtime != null && runtime > 0) {
      final hours = (runtime / 60).floor();
      final minutes = runtime % 60;
      texts.add('$hours h $minutes m');
    }

    final genres = model.movieDetails?.genres ?? [];
    if (genres.isNotEmpty) {
      texts.add(genres.map((genre) => genre.name).join(', '));
    }

    return texts;
  }
}