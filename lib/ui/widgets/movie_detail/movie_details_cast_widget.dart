import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_cast_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaCastWidget<MovieDetailsModel>(
      getCast: (model) => model?.movieDetails?.credits.cast,
      title: 'Series Cast',
    );
  }
}