import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_cast_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';

class TvShowDetailsMainInfoWidget extends StatelessWidget {
  const TvShowDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaCastWidget<TvShowDetailsModel>(
      getCast: (model) => model?.tvShowDetails?.credits.cast,
      title: 'Series Cast',
    );
  }
}