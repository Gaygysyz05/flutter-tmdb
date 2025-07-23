import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_main_info.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_main_screen_cast.dart';

class MovieDetailWidget extends StatefulWidget {
  final int movieId;

  const MovieDetailWidget({super.key, required this.movieId});

  @override
  State<MovieDetailWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demon Slayer',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: [
            MovieDetailMainInfo(),
            SizedBox(
              height: 30,
            ),
            MovieDetailsMainScreenCast()
          ],
        ),
      ),
    );
  }
}
