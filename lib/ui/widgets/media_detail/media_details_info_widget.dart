import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_cast.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_model.dart';

class MediaInfoWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final String? Function(T?) getOverview;
  final String? Function(T?) getBackdropPath;
  final String? Function(T?) getPosterPath;
  final String? Function(T?) getTitle;
  final int? Function(T?) getYear;
  final double Function(T?) getUserScore;
  final Widget Function(BuildContext, T?) buildScoreExtraWidget;
  final List<String> Function(T?) getSummaryTexts;
  final List<Employee>? Function(T?) getCrew;

  const MediaInfoWidget({
    super.key,
    required this.getOverview,
    required this.getBackdropPath,
    required this.getPosterPath,
    required this.getTitle,
    required this.getYear,
    required this.getUserScore,
    required this.buildScoreExtraWidget,
    required this.getSummaryTexts,
    required this.getCrew,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediaTopPosterWidget<T>(
          getBackdropPath: getBackdropPath,
          getPosterPath: getPosterPath,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MediaTitleWidget<T>(
            getTitle: getTitle,
            getYear: getYear,
          ),
        ),
        MediaScoreWidget<T>(
          getUserScore: getUserScore,
          buildExtraWidget: buildScoreExtraWidget,
        ),
        MediaSummaryWidget<T>(
          getSummaryTexts: getSummaryTexts,
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: MediaOverviewHeaderWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MediaDescriptionWidget<T>(
            getOverview: getOverview,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MediaPeopleWidget<T>(
            getCrew: getCrew,
          ),
        ),
      ],
    );
  }
}

class MediaTopPosterWidget<T extends MediaDetailsModel>
    extends StatelessWidget {
  final String? Function(T?) getBackdropPath;
  final String? Function(T?) getPosterPath;

  const MediaTopPosterWidget({
    super.key,
    required this.getBackdropPath,
    required this.getPosterPath,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final backdropPath = getBackdropPath(model);
    final posterPath = getPosterPath(model);

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
              icon: Icon(
                model?.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MediaTitleWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final String? Function(T?) getTitle;
  final int? Function(T?) getYear;

  const MediaTitleWidget({
    super.key,
    required this.getTitle,
    required this.getYear,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final title = getTitle(model) ?? 'Unknown Title';
    final year = getYear(model) ?? 'Unknown Year';

    return Center(
      child: RichText(
        maxLines: 3,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          TextSpan(
            text: ' ($year)',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          )
        ]),
      ),
    );
  }
}

class MediaScoreWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final double Function(T?) getUserScore;
  final Widget Function(BuildContext, T?) buildExtraWidget;

  const MediaScoreWidget({
    super.key,
    required this.getUserScore,
    required this.buildExtraWidget,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final userScore = getUserScore(model);
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
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        buildExtraWidget(context, model),
      ],
    );
  }
}

class MediaSummaryWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final List<String> Function(T?) getSummaryTexts;

  const MediaSummaryWidget({
    super.key,
    required this.getSummaryTexts,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final texts = getSummaryTexts(model);

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          texts.join(' '),
          textAlign: TextAlign.center,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class MediaOverviewHeaderWidget extends StatelessWidget {
  const MediaOverviewHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Overview',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}

class MediaDescriptionWidget<T extends MediaDetailsModel>
    extends StatelessWidget {
  final String? Function(T?) getOverview;

  const MediaDescriptionWidget({
    super.key,
    required this.getOverview,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final overview = getOverview(model) ?? '';

    return Text(
      overview,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}

class MediaPeopleWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final List<Employee>? Function(T?) getCrew;

  const MediaPeopleWidget({
    super.key,
    required this.getCrew,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    var crew = getCrew(model);
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
              child: MediaPeopleRow(employees: employees),
            ),
          )
          .toList(),
    );
  }
}

class MediaPeopleRow extends StatelessWidget {
  final List<Employee> employees;
  const MediaPeopleRow({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: employees
          .map((employee) => MediaPersonItem(employee: employee))
          .toList(),
    );
  }
}

class MediaPersonItem extends StatelessWidget {
  final Employee employee;
  const MediaPersonItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    const jobTitleStyle = TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: nameStyle),
          Text(employee.job, style: jobTitleStyle),
        ],
      ),
    );
  }
}
