import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_cast.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';

class TvShowDetailsInfoWidget extends StatelessWidget {
  const TvShowDetailsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: _MovieNamedWidget(),
        ),
        _ScoreWidget(),
        _SummeryWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _OverViewWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _PeopleWidgets(),
        ),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    final overview = model?.tvShowDetails?.overview ?? '';
    return Text(overview,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ));
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget();

  @override
  Widget build(BuildContext context) {
    return const Text('Overview',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ));
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    final backdropPath = model?.tvShowDetails?.backdropPath;
    final posterPath = model?.tvShowDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 398 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image(
                  image: NetworkImage(ApiClient.imageUrl(backdropPath)),
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image(
                    image: NetworkImage(ApiClient.imageUrl(posterPath)),
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: Icon(model?.isFavorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieNamedWidget extends StatelessWidget {
  const _MovieNamedWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    final year = model?.tvShowDetails?.firstAirDate?.year ?? 'Unknown Year';
    return Center(
      child: RichText(
          maxLines: 3,
          text: TextSpan(children: [
            TextSpan(
                text: model?.tvShowDetails?.name ?? 'Unknown Title',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
            TextSpan(
                text: ' ($year)',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16))
          ])),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    final userScore = model?.tvShowDetails?.voteAverage.toDouble() ?? 0.0;
    const textColor = TextStyle(color: Colors.white);
    const Color lineColor = Color.fromARGB(255, 37, 203, 103);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RadialPercentWidget(
                    percent: userScore / 10,
                    fillColor: const Color.fromARGB(255, 10, 23, 25),
                    lineColor: lineColor,
                    freeColor: const Color.fromARGB(255, 25, 54, 31),
                    lineWidth: 3,
                    child: Text(
                      '${(userScore * 10).round()}',
                      style: textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('User Score', style: TextStyle(color: lineColor)),
              ],
            )),
        Container(width: 1, height: 15, color: Colors.grey),
        const Text('What\'s your Vibe', style: textColor,)
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    var texts = <String>[];
    if (model == null) return const SizedBox.shrink();

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

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          texts.join(' '),
          textAlign: TextAlign.center,
          maxLines: 3,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    var crew = model?.tvShowDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks
          .add(crew.sublist(i, (i + 2 < crew.length) ? i + 2 : crew.length));
    }

    return Column(
      children: crewChunks
          .map(
            (employees) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PeopleWidgetsRow(employees: employees),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<Employee> employees;
  const _PeopleWidgetsRow({required this.employees});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: employees
          .map(
            (employee) => _PeopleWidgetsRowItem(employee: employee),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final Employee employee;
  const _PeopleWidgetsRowItem({required this.employee});

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16);
    const jobTitleStyle = TextStyle(
        color: Colors.orange, fontWeight: FontWeight.w400, fontSize: 16);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: nameStyle,
          ),
          Text(
            employee.job,
            style: jobTitleStyle,
          )
        ],
      ),
    );
  }
}
