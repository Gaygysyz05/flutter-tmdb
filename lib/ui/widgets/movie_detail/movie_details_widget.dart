import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_cast_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailsWidget> 
    with MediaDetailsStateMixin {

  @override
  void initState() {
    super.initState();
    initializeMediaModel<MovieDetailsModel>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupMediaLocale<MovieDetailsModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediaDetailsTitle<MovieDetailsModel>(
          getTitleCallback: (model) => model?.movieDetails?.title,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: MediaDetailsBody<MovieDetailsModel>(
          children: [
            MovieDetailsMainInfoWidget(),
            SizedBox(height: 30),
            MovieDetailsMainScreenCastWidget()
          ],
        ),
      ),
    );
  }
}