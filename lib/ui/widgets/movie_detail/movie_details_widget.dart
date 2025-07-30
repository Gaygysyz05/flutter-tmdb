import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_main_info.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_main_screen_cast.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: [
            const MovieDetailMainInfo(),
            const SizedBox(
              height: 30,
            ),
            const MovieDetailsMainScreenCast()
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.title ?? 'Loading...',
      style: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
