import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_info_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';

class TvShowDetailsInfoWidget extends StatelessWidget {
  const TvShowDetailsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaInfoWidget<TvShowDetailsModel>(
      getOverview: (model) => model?.tvShowDetails?.overview,
      getBackdropPath: (model) => model?.tvShowDetails?.backdropPath,
      getPosterPath: (model) => model?.tvShowDetails?.posterPath,
      getTitle: (model) => model?.tvShowDetails?.name,
      getYear: (model) => model?.tvShowDetails?.firstAirDate?.year,
      getUserScore: (model) => model?.tvShowDetails?.voteAverage.toDouble() ?? 0.0,
      buildScoreExtraWidget: (context, model) => _buildTvShowExtraWidget(model),
      getSummaryTexts: _getTvShowSummaryTexts,
      getCrew: (model) => model?.tvShowDetails?.credits.crew,
    );
  }

  Widget _buildTvShowExtraWidget(TvShowDetailsModel? model) {
    const textColor = TextStyle(color: Colors.white);
    return const Text('What\'s your Vibe', style: textColor);
  }

  List<String> _getTvShowSummaryTexts(TvShowDetailsModel? model) {
    var texts = <String>[];
    if (model == null) return texts;

    final releaseDate = model.tvShowDetails?.firstAirDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final originCountry = model.tvShowDetails?.originCountry;
    if (originCountry != null && originCountry.isNotEmpty) {
      texts.add('(${originCountry[0]})');
    }

    final genres = model.tvShowDetails?.genres ?? [];
    if (genres.isNotEmpty) {
      texts.add(genres.map((genre) => genre.name).join(', '));
    }

    return texts;
  }
}