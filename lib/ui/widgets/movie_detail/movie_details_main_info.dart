import 'package:flutter/material.dart';
import 'package:themoviedb/ui/elements/radial_percent_widget.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieDetailMainInfo extends StatelessWidget {
  const MovieDetailMainInfo({super.key});

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
        _PeopleWidgets(),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
        'As the Demon Slayer Corps members and Hashira engaged in a group strength training program, the Hashira Training, in preparation for the forthcoming battle against the demons, Muzan Kibutsuji appears at the Ubuyashiki Mansion.',
        style: TextStyle(
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
    return const Stack(
      children: [
        Image(image: AssetImage(AppImages.topHeader)),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(image: AssetImage(AppImages.topHeaderSubImage)),
        ),
      ],
    );
  }
}

class _MovieNamedWidget extends StatelessWidget {
  const _MovieNamedWidget();

  @override
  Widget build(BuildContext context) {
    return RichText(
        maxLines: 3,
        text: const TextSpan(children: [
          TextSpan(
              text: 'Demon Slayer',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
          TextSpan(
              text: ' (2025)',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))
        ]));
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RadialPercentWidget(
                    percent: 0.72,
                    fillColor: Color.fromARGB(255, 10, 23, 25),
                    lineColor: Color.fromARGB(255, 37, 203, 103),
                    freeColor: Color.fromARGB(255, 25, 54, 31),
                    lineWidth: 3,
                    child: Text('72'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('User Score'),
              ],
            )),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(Icons.play_arrow),
                Text('Play Trailer'),
              ],
            )),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          '07/18/2025 (JP) 2h 35m   Animation, Action, Fantasy, Thrille',
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(
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
    const nameStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16);

    const jobTitleStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16);

    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haruo Sotozaki',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyle,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haruo Sotozaki',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyle,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haruo Sotozaki',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyle,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haruo Sotozaki',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyle,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
